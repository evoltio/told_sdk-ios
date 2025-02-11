//
//  WidgetManager.swift
//  Told
//
//  Created by Jérémy Magnier on 19/01/2025.
//

import UIKit
import Combine

final class WidgetManager {
    private let logger: Logger
    private var window: UIWindow?
    private var task: Task<Void, Never>?

    init(
        logger: Logger
    ) {
        self.logger = logger
    }

    @MainActor
    func presentWidget(
        anonymousId: String,
        surveyId: String,
        delay: TimeInterval = 0,
        core: ToldCore
    ) {
        task?.cancel()
        task = Task {
            do {
                try await Task.sleep(for: .seconds(delay))
                if let window = createWindowIfNeeded() {
                    if window.rootViewController == nil {
                        let widgetController = WidgetController(
                            viewModel: WidgetViewModelImpl(
                                anonymousId: anonymousId,
                                surveyId: surveyId,
                                configuration: core.configuration,
                                logger: logger,
                                onClose: { [weak core, weak window] in
                                    core?.closeSurvey()
                                    window?.isHidden = true
                                    window?.rootViewController = nil
                                }
                            )
                        )
                        window.isHidden = false
                        window.rootViewController = widgetController
                        core.updateCurrentSurvey(id: surveyId)
                        // Resign current first responder
                        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
                    } else {
                        logger.log(level: .debug, message: "Widget already presented")
                    }
                }
            } catch {
                logger.log(level: .debug, message: "Cancel widget presentation")
            }
        }
    }

    private func createWindowIfNeeded() -> UIWindow? {
        if let window = window {
            return window
        } else {
            guard
                let windowScene = UIApplication.shared.connectedScenes.first { scene in
                    scene is UIWindowScene
                } as? UIWindowScene
            else { return nil }
            // We use passthrough window because the window will remain present
            let window: UIWindow = PassthroughWindow(windowScene: windowScene)
            self.window = window
            return window
        }
    }
}
