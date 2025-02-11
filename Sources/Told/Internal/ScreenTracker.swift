//
//  ScreenTracker.swift
//  Told
//
//  Created by Jérémy Magnier on 26/01/2025.
//

import UIKit
import SwiftUI
import Combine

private extension Bundle {
    // We assume that the product module name is the product name with the c99ext standard
    var c99extidentifierBundleExecutableName: String? {
        guard let bundleExecutableName = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String else { return nil }
        return  bundleExecutableName.replacing(/[^[:alnum:]]/, with: "_")
    }
}

private extension ScreenTracker {
    static let controllerDidAppearNotification = Notification.Name(rawValue: "ScreenTrackerControllerDidAppearNotification")
}

final class ScreenTracker {
    private let c99extidentifierBundleExecutableName: String
    private let logger: Logger
    private var cancellable: AnyCancellable?
    private let queue = DispatchQueue(label: "club.told.widget.ScreenTracker", qos: .utility)
    private let activationQueue = DispatchQueue(label: "club.told.widget.ActivationQueue")
    private var isActive: Bool = false
    weak var core: ToldCore?

    init?(logger: Logger) {
        guard let c99extidentifierBundleExecutableName = Bundle.main.c99extidentifierBundleExecutableName else { return nil }
        self.c99extidentifierBundleExecutableName = c99extidentifierBundleExecutableName
        self.logger = logger
        observeNotificationController()
    }

    func activate() {
        activationQueue.async { [weak self] in
            guard let self else { return }
            guard !isActive else { return }
            swizzle()
            observeNotificationController()
            isActive = true
            logger.log(level: .debug, message: "Swizzle activated")
        }
    }

    func deactivate() {
        activationQueue.async { [weak self] in
            guard let self else { return }
            guard isActive else { return }
            swizzle()
            cancellable?.cancel()
            cancellable = nil
            isActive = false
            logger.log(level: .debug, message: "Swizzle deactivated")
        }
    }

    private func observeNotificationController() {
        cancellable = NotificationCenter.default.publisher(for: ScreenTracker.controllerDidAppearNotification)
            .compactMap { notification in
                notification.object
            }
            .receive(on: queue)
            .compactMap { $0 as? UIViewController }
            .removeDuplicates()
            .compactMap { [weak self] controller in
                self?.extractControllerName(controller)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pageName in
                self?.core?.trackChangePage(pageName: pageName)
            }
    }

    private func extractControllerName(_ controller: Any) -> String? {
        // The name of the UIViewController type including the module name
        let controllerNameReflected: String = String(reflecting: type(of: controller))
        logger.log(level: .debug, message: "Extract controller name: \(controllerNameReflected)")

        if controllerNameReflected.hasPrefix(c99extidentifierBundleExecutableName) {
            // The controller is an UKit controller from the app
            // String(describing:) doesn't include module name
            let controllerName: String = String(describing: type(of: controller))
            return controllerName
        } else if let swiftUIController = controller as? RootViewable {
            // Return nil for now instead of searching the swiftui view in the view hierarchy description
            return nil

            // The controller is a SwiftUI UIHostingController that will probably contains the View
            // in his description, this is not yet stable
            let rootViewDescription: String = String(describing: swiftUIController._rootView)
            guard
                // Regex for extracting the viewName
                let regex = try? Regex("ModifiedContent<(Swift.Optional<)?\(c99extidentifierBundleExecutableName).(?<viewName>[[:alnum:]|_]+)"),
                let viewName = try! regex.firstMatch(in: rootViewDescription)?.output["viewName"]?.value as? Substring
            else {
                return nil
            }
            return String(viewName)
        }
        return nil
    }
}

// Swizzle the viewDidAppear method for tracking screen name
private extension ScreenTracker {
    private func swizzle() {
        guard let originalMethod = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.viewDidAppear(_:))) else { return }
        guard let swizzledMethod = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.told_viewDidAppear(_:))) else { return }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

private extension UIViewController {
    @objc func told_viewDidAppear(_ animated: Bool) {
        // Post a notification with the controller
        if
            let window = viewIfLoaded?.window,
            !(window is PassthroughWindow),
            let visibleViewController = window.rootViewController?._visibleViewController() {
            NotificationCenter.default.post(
                name: ScreenTracker.controllerDidAppearNotification,
                object: visibleViewController
            )
        }

        // by calling told_viewDidAppear we call the real viewDidAppear implementation since the methods has been swizzled
        told_viewDidAppear(animated)
    }
}

private extension UIViewController {
    func _visibleViewController() -> UIViewController? {
        let controller: UIViewController?
        if let presentedViewController = self.presentedViewController {
            controller = presentedViewController._visibleViewController()
        } else if let navigationController = self as? UINavigationController {
            controller = navigationController.visibleViewController?._visibleViewController()
        } else if let tabBarController = self as? UITabBarController {
            controller = tabBarController.selectedViewController?._visibleViewController()
        } else if self is RootViewable {
            controller = children.first?._visibleViewController()
        } else {
            controller = nil
        }
        return controller ?? self
    }
}

// UIHostingController is a generic type, we can't cast it without knowing the Content type,
// so this is a trick for accessing rootView
extension UIHostingController: RootViewable {
    var _rootView: any View { rootView }
}

private protocol RootViewable {
    var _rootView: any View { get }
}
