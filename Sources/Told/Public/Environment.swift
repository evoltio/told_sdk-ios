//
//  Environment.swift
//  Told
//
//  Created by Jérémy Magnier on 14/01/2025.
//

import Foundation

/// The environment to use for Told initialization
public struct ToldEnvironment {
    // The server URL
    let serverUrl: URL
    // The webView URL
    let widgetUrl: URL

    init(serverUrl: URL, widgetUrl: URL) {
        self.serverUrl = serverUrl
        self.widgetUrl = widgetUrl
    }
}

extension ToldEnvironment {
    /// The `ToldEnvironment` production
    public static let production: ToldEnvironment = .init(
        serverUrl: URL(string: "https://api.told.club/graphql")!,
        widgetUrl: URL(string: "https://widget.told.club")!
    )

    /// The `ToldEnvironment` development
    public static let development: ToldEnvironment = .init(
        serverUrl: URL(string: "https://testapi.told.club/graphql")!,
        widgetUrl: URL(string: "https://testwidget.told.club")!
    )

    @available(*, deprecated, message: "This API is internal and could change in the future without notice. Use it only if you know what you do.")
    public static func custom(serverUrl: URL, widgetUrl: URL) -> ToldEnvironment {
        .init(
            serverUrl: serverUrl,
            widgetUrl: widgetUrl
        )
    }
}
