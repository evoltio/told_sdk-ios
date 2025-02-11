//
//  WidgetController.swift
//  Told
//
//  Created by Jérémy Magnier on 19/01/2025.
//

import WebKit
import Combine
import SafariServices

protocol WidgetViewModel {
    var logger: Logger { get }
    var urlRequest: URLRequest { get }
    
    func closeSurvey()
}

extension WidgetController {
    enum Constants {
        static let additionalSafeAreaInsets: UIEdgeInsets = .init(
            top: 0,
            left: 16,
            bottom: 8,
            right: 16
        )

        static let handlerName: String = "iosHandler"
    }
}

final class WidgetController: UIViewController {
    private let viewModel: WidgetViewModel
    private let jsonDecoder: JSONDecoder = .init()
    private var webView: WKWebView?
    private var lastHeight: CGFloat = 0
    private var cancellables: Set<AnyCancellable> = .init()

    init(
        viewModel: WidgetViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalSafeAreaInsets = Constants.additionalSafeAreaInsets
        presentWebView()
        observeKeyBoardNotifications()
    }

    private func observeKeyBoardNotifications() {
        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .compactMap { notification in
                return notification.userInfo.flatMap { userInfo -> (CGRect, CGFloat)? in
                    guard let keyBoardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
                    let animationDuration: CGFloat = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat ?? 0.35

                    return (keyBoardEndFrame, animationDuration)
                }
            }
            .sink { [weak self] (keyBoardEndFrame, animationDuration) in
                guard let self, let webView, let view else { return }
                webView.scrollView.isScrollEnabled = false
                UIView.animate(withDuration: animationDuration) {
                    let newHeight: CGFloat = min(webView.frame.size.height, view.safeAreaLayoutGuide.layoutFrame.height - keyBoardEndFrame.height + view.safeAreaInsets.bottom)
                    webView.frame.origin.y = view.safeAreaLayoutGuide.layoutFrame.minY
                    webView.frame.size.height = newHeight
                }
            }
            .store(in: &cancellables)


        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .sink { [weak self] _ in
                guard let self, let webView, lastHeight != 0 else { return }
                webView.scrollView.isScrollEnabled = true
                let newSize: CGSize = .init(
                    width: view.safeAreaLayoutGuide.layoutFrame.width,
                    height: lastHeight
                )
                let newOrigin: CGPoint = .init(
                    x: view.safeAreaLayoutGuide.layoutFrame.minX,
                    y: view.safeAreaLayoutGuide.layoutFrame.maxY - lastHeight
                )
                UIView.animate(withDuration: 0.35) {
                    webView.frame = .init(
                        origin: newOrigin,
                        size: newSize
                    )
                }
            }
            .store(in: &cancellables)
    }

    func presentWebView() {
        let safeAreaFrame: CGRect = view.safeAreaLayoutGuide.layoutFrame.inset(by: Constants.additionalSafeAreaInsets)

        let userContentController: WKUserContentController = .init()
        userContentController.add(self, name: Constants.handlerName)

        let configuration: WKWebViewConfiguration = .init()
        configuration.userContentController = userContentController

        let webView: WKWebView = .init(
            frame: CGRect(
                origin: CGPoint(
                    x: safeAreaFrame.minX,
                    y: view.frame.maxY
                ),
                size: safeAreaFrame.size
            ),
            configuration: configuration
        )
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.clipsToBounds = false
        webView.isOpaque = false

        self.webView = webView
        view.addSubview(webView)
        webView.load(viewModel.urlRequest)
    }
}

extension WidgetController: WKScriptMessageHandler {
    private func handleMessage(_ webView: WKWebView, _ message: WebViewMessage) {
        switch message.type {
        case .isLoaded:
            //  Use this view to disable hit testing bellow the webView
            let backgroundView: UIView = .init()
            backgroundView.frame = view.frame
            view.insertSubview(backgroundView, belowSubview: webView)
        case .close:
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                guard let self else { return }
                webView.frame.origin.y = view.frame.maxY
            }, completion: { [weak self] _ in
                guard let self else { return }
                // Stop retain cycle by removing scriptMessageHandlers
                webView.configuration.userContentController.removeAllScriptMessageHandlers()
                webView.removeFromSuperview()
                self.webView = nil
                viewModel.closeSurvey()
            })
        case let .heightChange(newHeight, firstPosition):
            let newHeight: CGFloat = min(newHeight, view.safeAreaLayoutGuide.layoutFrame.height)
            self.lastHeight = newHeight
            let newSize: CGSize = .init(
                width: view.safeAreaLayoutGuide.layoutFrame.width,
                height: newHeight
            )
            let newOrigin: CGPoint = .init(
                x: view.safeAreaLayoutGuide.layoutFrame.minX,
                y: view.safeAreaLayoutGuide.layoutFrame.maxY - newHeight
            )

            // The webview is currently hidden
            if firstPosition {
                webView.frame.size = newSize
                UIView.animate(withDuration: 0.35) {
                    webView.frame.origin = newOrigin
                }
            } else {
                UIView.animate(withDuration: 0.35) {
                    webView.frame = .init(
                        origin: newOrigin,
                        size: newSize
                    )
                }
            }
        case let .launchCalendar(url), let .openLink(url):
            openLink(url: url)
        case .closeCalendar:
            dismiss(animated: true)
        case .updatePosition, .addCookie, .unknown:
            break
        }
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let webView = message.webView else { return }
        guard message.name == Constants.handlerName else { return }
        do {
            guard let body = message.body as? String else { return }
            let data: Data = Data(body.utf8)
            let json: Any = try JSONSerialization.jsonObject(with: data)
            let jsonData: Data = try JSONSerialization.data(withJSONObject: json, options: [])
            if let json = json as? [String: Any], json["id"] != nil {
                let toldMessage: WebViewMessage = try jsonDecoder.decode(WebViewMessage.self, from: jsonData)
                handleMessage(webView, toldMessage)
            }
        } catch {
            viewModel.logger.log(level: .error, message: "Error parsing message: \(error.localizedDescription)")
        }
    }
}

extension WidgetController {
    private func openLink(url: String) {
        guard let url = URL(string: url) else { return }
        let safariController: SFSafariViewController = .init(url: url)
        present(safariController, animated: true)
    }
}

extension WidgetController: WKNavigationDelegate {

    // When the page finishes loading, inject scripts
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // TODO: Still used ?
        webView.evaluateJavaScript("window.postMessage({type: 'OS_TYPE', value: 'IOS'});")
        webView.evaluateJavaScript("window.postMessage({type: 'DEVICE_TYPE', value: 'phone'});")

        // Evaluate the script to post message to your userContentController
        webView.evaluateJavaScript("window.addEventListener('message', (event) => { window.webkit.messageHandlers.\(Constants.handlerName).postMessage(JSON.stringify(event.data), '*'); });")

        // Evaluate the script to disable text selection
        let disableTextSelectionScript: String = "var css = '*{-webkit-touch-callout:none;-webkit-user-select:none}'; var style = document.createElement('style'); style.type = 'text/css'; style.appendChild(document.createTextNode(css)); document.head.appendChild(style);"
        webView.evaluateJavaScript(disableTextSelectionScript)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        if navigationAction.navigationType == .linkActivated, let url = navigationAction.request.url {
            openLink(url: url.absoluteString)
            return .cancel
        } else {
            return .allow
        }
    }
}

extension WidgetController: WKUIDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        viewModel.logger.log(level: .error, message: "Failed to load webView: \(error.localizedDescription)")
    }
}
