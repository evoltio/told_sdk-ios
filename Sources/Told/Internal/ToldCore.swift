//
//  ToldCore.swift
//  Told
//
//  Created by Jérémy Magnier on 17/01/2025.
//

import Foundation

final class ToldCore {
    let configuration: ToldConfiguration

    private let remote: RemoteService
    private let local: LocalService
    private let logger: Logger
    private let widgetManager: WidgetManager
    private let screenTracker: ScreenTracker?

    private var isAppAllowed: Bool?
    private var _currentTask: Task<Void, Error>?

    init(
        configuration: ToldConfiguration,
        remote: RemoteService,
        local: LocalService,
        logger: Logger
    ) {
        self.configuration = configuration
        self.remote = remote
        self.local = local
        self.logger = logger
        self.widgetManager = .init(logger: logger)
        self.screenTracker = .init(logger: logger)
        screenTracker?.core = self
        local.remove(.lastPage)
        local.remove(.currentSurvey)
        logger.log(level: .info, message: "Told initialized")
    }

    func activateScreenTracker() {
        screenTracker?.activate()
    }

    func deactivateScreenTracker() {
        screenTracker?.deactivate()
    }

    func logAlreadyInitialized() {
        logger.log(level: .debug, message: "Told is already initialized")
    }

    func identify(property: [String: AnyHashable]) {
        Task {
            do {
                try await withCurrentTask { [weak self] in
                    guard let self else { return }
                    guard try await self.checkIfAppIsAllowed() else { return }
                    let anonymousId: String? = try await remote.identify(
                        anonymousId: getAnonymousId(),
                        sourceId: configuration.sourceId,
                        customData: property
                    )
                    if let anonymousId {
                        local.set(anonymousId, for: .anonymousId)
                        logger.log(level: .info, message: "Identify successfully with new anonymous id \(anonymousId)")
                    } else {
                        logger.log(level: .info, message: "Identity finish without new anonymous id")
                    }
                    await trackIdentify()
                }
            } catch {
                logger.log(level: .error, message: "Identify failed: \(error.localizedDescription)")
            }
        }
    }

    private func trackIdentify() async {
        do {
            try await remote.trackIdentify(
                anonymousId: getAnonymousId(),
                sourceId: configuration.sourceId,
                primaryData: getPrimaryData()
            )
            logger.log(level: .error, message: "TrackIdentify successfully")
        } catch {
            logger.log(level: .error, message: "TrackIdentify failed: \(error.localizedDescription)")
        }
    }

    func reset() {
        Task {
            do {
                try await withCurrentTask { [weak self] in
                    guard let self else { return }
                    guard try await self.checkIfAppIsAllowed() else { return }
                    try await remote.reset(
                        anonymousId: getAnonymousId(),
                        sourceId: configuration.sourceId,
                        primaryData: getPrimaryData()
                    )
                    local.remove(.anonymousId)
                    local.remove(.currentSurvey)
                    local.remove(.lastPage)
                    local.remove(.language)
                    logger.log(level: .info, message: "Reset anonymousId successfully")
                }
            } catch {
                logger.log(level: .error, message: "Reset failed: \(error.localizedDescription)")
            }
        }
    }

    func trackChangePage(pageName: String) {
        Task {
            do {
                try await withCurrentTask { [weak self] in
                    guard let self else { return }
                    guard try await self.checkIfAppIsAllowed() else { return }
                    if let lastPageName = local.get(.lastPage), lastPageName == pageName {
                        return
                    }
                    local.set(pageName, for: .lastPage)
                    logger.log(level: .debug, message: "Track change page: \(pageName)")
                    let trackEventResult: TrackEventResult = try await  remote.trackChangePage(
                        anonymousId: getAnonymousId(),
                        sourceId: configuration.sourceId,
                        primaryData: getPrimaryData()
                    )
                    try await handleTrackEventResult(trackEventResult)
                }
            } catch {
                logger.log(level: .error, message: "Failed to track event: \(error.localizedDescription)")
            }
        }
    }

    func trackEvent(eventName: String, properties: [String: AnyHashable]) {
        Task {
            do {
                try await withCurrentTask { [weak self] in
                    guard let self else { return }
                    guard try await self.checkIfAppIsAllowed() else { return }
                    logger.log(level: .debug, message: "Track event name: \(eventName)")
                    let languageProperty: [String: AnyHashable] = ["language": getLanguageCode()]
                    let trackEventResult: TrackEventResult = try await  remote.trackCustomEvent(
                        anonymousId: getAnonymousId(),
                        sourceId: configuration.sourceId,
                        customName: eventName,
                        customData: properties.merging(languageProperty, uniquingKeysWith: { value, _ in
                            value
                        }),
                        primaryData: getPrimaryData()
                    )
                    try await handleTrackEventResult(trackEventResult)
                }
            } catch {
                logger.log(level: .error, message: "Failed to track event: \(error.localizedDescription)")
            }
        }
    }

    func closeSurvey() {
        Task {
            do {
                try await withCurrentTask { [weak self] in
                    guard let self else { return }
                    guard try await self.checkIfAppIsAllowed() else { return }
                    try await remote.trackCloseSurvey(
                        anonymousId: getAnonymousId(),
                        sourceId: configuration.sourceId,
                        primaryData: getPrimaryData()
                    )
                    local.remove(.currentSurvey)
                }
            } catch {
                logger.log(level: .error, message: "Failed to send event close survey: \(error.localizedDescription)")
            }
        }
    }

    func updateCurrentSurvey(id: String) {
        local.set(id, for: .currentSurvey)
    }

    func debugWidget() {
        Task {
            do {
                let debug: String? = try await remote.debugWidget(
                    sourceId: configuration.sourceId,
                    serverUrl: configuration.environment.serverUrl
                )
                if let debug {
                    logger.log(level: .info, message: debug)
                }
            } catch {
                logger.log(level: .error, message: "Failed to debug")
            }
        }
    }

    func start(surveyId: String, delay: TimeInterval) {
        Task {
            do {
                try await withCurrentTask { [weak self] in
                    guard let self else { return }
                    guard try await self.checkIfAppIsAllowed() else { return }
                    try await checkAndStart(surveyId: surveyId, delay: delay)
                }
            } catch {
                logger.log(level: .error, message: "Failed to start survey \(surveyId): \(error.localizedDescription)")
            }
        }
    }

    func checkAndStart(surveyId: String, delay: TimeInterval) async throws {
        if try await remote.checkIfCanUse(
            surveyId: surveyId,
            applicationId: configuration.applicationId,
            serverUrl: configuration.environment.serverUrl.absoluteURL
        ) {
            logger.log(level: .debug, message: "Can use survey \(surveyId)")
            let anonymousId: String = try await getAnonymousId()
            await widgetManager.presentWidget(
                anonymousId: anonymousId,
                surveyId: surveyId,
                delay: delay,
                core: self
            )
        } else {
            logger.log(level: .debug, message: "Can't use survey \(surveyId)")
        }
    }

    private func handleTrackEventResult(_ result: TrackEventResult) async throws {
        switch result {
        case .triggerOn(let surveyId, let delay):
            let delay: Int = delay ?? .zero
            logger.log(level: .debug, message: "Trigger survey \(surveyId), delay \(delay)")
            try await checkAndStart(surveyId: surveyId, delay: TimeInterval(delay))
        case .noTrigger:
            logger.log(level: .debug, message: "No trigger")
        }
    }

    private func getAnonymousId() async throws -> String {
        do {
            if let anonymousId = local.get(.anonymousId) {
                return anonymousId
            } else {
                let anonymousId: String = try await remote.getAnonymousId()
                local.set(anonymousId, for: .anonymousId)
                logger.log(level: .debug, message: "Get AnonymousId: \(anonymousId)")
                return anonymousId
            }
        } catch {
            logger.log(level: .error, message: "Failed to retrieve anonymousId")
            throw error
        }
    }

    private func getPrimaryData() -> PrimaryEventData {
        PrimaryEventData(
            language: getLanguageCode(),
            version: configuration.appVersion,
            pageName: local.get(.lastPage),
            survey: local.get(.currentSurvey)
        )
    }

    private func getLanguageCode() -> String? {
        local.get(.language) ?? {
            Locale
                .preferredLanguages
                .first
                .flatMap(Locale.Language.init)?
                .languageCode?
                .identifier(.alpha2)
        }()
    }

    private func checkIfAppIsAllowed() async throws -> Bool {
        do {
            if let isAppAllowed = isAppAllowed {
                return isAppAllowed
            } else {
                let isAppAllowed: Bool = try await remote.checkIfAppIsAllowed(
                    sourceId: configuration.sourceId,
                    applicationId: configuration.applicationId,
                    hostName: configuration.environment.serverUrl.absoluteString
                )
                self.isAppAllowed = isAppAllowed
                logger.log(level: .debug, message: "This app is \(isAppAllowed ? "allowed" : "not allowed")")
                return isAppAllowed
            }
        } catch {
            logger.log(level: .error, message: "Failed to check if the app is allowed")
            throw error
        }
    }

    private func withCurrentTask<Success>(operation: sending @escaping @isolated(any) () async throws -> Success) async throws -> Success {
        try await _currentTask?.value
        let task: Task<Success, Error> = .init {
            try await operation()
        }
        _currentTask = Task {
            let _ = try? await task.value
        }
        return try await task.value
    }
}
