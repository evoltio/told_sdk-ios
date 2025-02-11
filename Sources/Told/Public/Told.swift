//
//  Told.swift
//  Told
//
//  Created by Jérémy Magnier on 14/01/2025.
//

import Foundation
import UIKit

public final class Told {
    private static var _core: ToldCore?
    private static var core: ToldCore? {
        if _core == nil {
            DefaultLogHandler().log(level: .error, message: "Told init configuration should be called")
        }
        return _core
    }


    /// Initialize Told with the given configuration.
    /// - Parameters:
    ///    - configuration: The `ToldConfiguration` to use
    ///    - logHandler: Your custom `LogHandler` implemantion, `nil` by default
    ///    If nil the default implemenation will be use
    ///    - debug: Enable the debugging log, `false`by default
    public static func `init`(
        _ configuration: ToldConfiguration,
        logHandler: (any LogHandler)? = nil,
        debug: Bool = false
    ) {
        if let core = _core {
            core.logAlreadyInitialized()
        } else {
            _core = ToldCore(
                configuration: configuration,
                remote: RemoteService(
                    serverURL: configuration.environment.serverUrl
                ),
                local: LocalService(
                    userDefault: UserDefaults(
                        suiteName: "club.told.widget.storage.\(configuration.sourceId)"
                    )!
                ),
                logger: Logger(
                    handler: logHandler ?? DefaultLogHandler(),
                    debug: debug
                )
            )
        }
    }
    
    /// Activate automatic screen tracking with swizzling on the ``UIViewController/viewDidAppear(_:)`` method
    /// SwiftUI controllers will be skipped
    public static func activateAutomaticScreenTracking() {
        core?.activateScreenTracker()
    }

    /// Desactivate automatic screen tracking
    public static func deactivateAutomaticScreenTracking() {
        core?.deactivateScreenTracker()
    }

    /// Update the language
    /// - Parameters:
    ///    - language: The language identifier.
    public static func updateLanguage(
        _ language: String
    ) {
        core?.updateLanguage(language)
    }

    /// Identify the current user with custom properties
    /// - Parameters:
    ///   - properties: The custom properties to use for the user identification.
    public static func identify(
        properties: [String: AnyHashable]
    ) {
        core?.identify(property: properties)
    }

    /// Track a custom event
    /// - Parameters:
    ///   - eventName: The event name of your custom event provided on the `Trigger` section in your back-office interface.
    ///   - properties: The properties to use for the event.
    public static func trackEvent(
        _ eventName: String,
        properties: [String: AnyHashable] = [:]
    ) {
        core?.trackEvent(
            eventName: eventName,
            properties: properties
        )
    }

    /// Start a survey with the provided `surveyId`
    /// - Parameters:
    ///   - surveyId: The `identifier` of the survey to start.
    ///   - delay: The delay before starting the survey, no delay by default.
    public static func start(
        surveyId: String,
        delay: TimeInterval = 0
    ) {
        core?.start(
            surveyId: surveyId,
            delay: delay
        )
    }

    /// Reset all the data, the configuration remains unchanged
    public static func reset() {
        core?.reset()
    }

    /// Log information about your source and your surveys.
    /// It will be displayed with the `info`  log level
    public static func debugWidget() {
        core?.debugWidget()
    }

    /// Track a change page event
    /// - Parameter pageName: The page name provided on the `Trigger` section in your back-office interface
    public static func trackChangePage(_ pageName: String) {
        core?.trackChangePage(pageName: pageName)
    }
}
