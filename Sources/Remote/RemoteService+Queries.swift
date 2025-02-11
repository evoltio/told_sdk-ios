//
//  RemoteService+Queries.swift
//  Told
//
//  Created by Jérémy Magnier on 15/01/2025.
//

import Apollo
import Foundation

extension RemoteService {

    func checkIfAppIsAllowed(
        sourceId: SourceId,
        applicationId: String,
        hostName: String
    ) async throws -> Bool {
        let graphQLResult: GraphQLResult<ToldAPI.CheckIfAppIsAllowedQuery.Data>
        do {
            graphQLResult = try await apolloClient.fetchAsync(
                query: ToldAPI.CheckIfAppIsAllowedQuery(
                    sourceId: sourceId,
                    host: .some(
                        ToldAPI.ClientAppWebInput(
                            hostname: .some(hostName)
                        )
                    ),
                    mobile: .some(
                        ToldAPI.ClientAppMobileInput(
                            app: .some(applicationId),
                            os: .some(ToldAPI.OS.ios.rawValue)
                        )
                    )
                )
            )
        } catch {
            throw NetworkError.apolloError(error)
        }
        return try graphQLResult.dataAssertNoError().checkIfAppIsAllowed?.allowed ?? false
    }

    func checkIfCanUse(
        surveyId: String,
        applicationId: String,
        serverUrl: URL
    ) async throws -> Bool {
        let graphQLResult: GraphQLResult<ToldAPI.CheckIfCanUseWidgetWithSurveyQuery.Data>
        do {
            graphQLResult = try await apolloClient.fetchAsync(
                query: ToldAPI.CheckIfCanUseWidgetWithSurveyQuery(
                    surveyID: surveyId,
                    hostname: .some(serverUrl.absoluteString),
                    port: .none,
                    preview: .none,
                    os: .some(ToldAPI.OS.ios.rawValue),
                    mobileApp: .some(applicationId)
                )
            )
        } catch {
            throw NetworkError.apolloError(error)
        }
        return try graphQLResult.dataAssertNoError().checkIfCanUseWidgetWithSurvey?.canUse ?? false
    }

    func debugWidget(
        sourceId: SourceId,
        serverUrl: URL
    ) async throws -> String? {
        let graphQLResult: GraphQLResult<ToldAPI.DebugWidgetQuery.Data>
        do {
            graphQLResult = try await apolloClient.fetchAsync(
                query: ToldAPI.DebugWidgetQuery(
                    id: sourceId,
                    type: .none,
                    hostname: .some(serverUrl.absoluteString),
                    port: .none
                )
            )
        } catch {
            throw NetworkError.apolloError(error)
        }
        return try graphQLResult.dataAssertNoError().debugWidget
    }
}
