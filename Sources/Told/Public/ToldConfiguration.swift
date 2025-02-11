//
//  Configuration.swift
//  Told
//
//  Created by Jérémy Magnier on 14/01/2025.
//

/// The configuration required to initialize and operate the Told SDK.
public struct ToldConfiguration {
    let sourceId: String
    let applicationId: String
    let environment: ToldEnvironment
    let appVersion: String

    /// - Parameters:
    ///   - sourceId: The unique identifier for the data source. You can find it on the Told's initialization page of your app.
    ///   - applicationId: The application's bundle identifier.
    ///   - environment: See `ToldEnvironment`. Make sure the `sourceId` you used is configured for the right environment.
    ///   - appVersion: The version of your application.
    public init(
        sourceId: String,
        applicationId: String,
        environment: ToldEnvironment,
        appVersion: String
    ) {
        self.sourceId = sourceId
        self.applicationId = applicationId
        self.environment = environment
        self.appVersion = appVersion
    }
}
