//
//  WidgetViewModelImpl.swift
//  Told
//
//  Created by Jérémy Magnier on 24/01/2025.
//

import Foundation

final class WidgetViewModelImpl: WidgetViewModel {
    private let surveyId: String
    private let anonymousId: String
    private let configuration: ToldConfiguration
    private let onClose: () -> Void

    let logger: Logger
    var urlRequest: URLRequest {
        let url: URL = configuration.environment.widgetUrl.appending(
            queryItems: [
                URLQueryItem(name: "id", value: surveyId),
                URLQueryItem(name: "sourceID", value: configuration.sourceId),
                URLQueryItem(name: "anonymousID", value: anonymousId)
            ]
        )
        return URLRequest(url: url)
    }

    init(
        anonymousId: String,
        surveyId: String,
        configuration: ToldConfiguration,
        logger: Logger,
        onClose: @escaping () -> Void
    ) {
        self.anonymousId = anonymousId
        self.surveyId = surveyId
        self.configuration = configuration
        self.logger = logger
        self.onClose = onClose
    }

    func closeSurvey() {
        onClose()
    }
}
