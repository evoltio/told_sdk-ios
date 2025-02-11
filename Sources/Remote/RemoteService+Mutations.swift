//
//  RemoteService+Mutations.swift
//  Told
//
//  Created by Jérémy Magnier on 15/01/2025.
//

import Foundation
import Apollo

extension RemoteService {

    func getAnonymousId() async throws -> AnonymousId {
        let graphQLResult: GraphQLResult<ToldAPI.GetAnonymousIdMutation.Data>
        do {
            graphQLResult = try await apolloClient.performAsync(
                mutation: ToldAPI.GetAnonymousIdMutation(
                    anonymousId: .none,
                    hiddenFields: .none
                )
            )
        } catch {
            throw NetworkError.apolloError(error)
        }
        let data = try graphQLResult.dataAssertNoError()
        guard let anonymousId = data.getAuthor.anonymousID else {
            throw NetworkError.unexpected
        }
        return anonymousId
    }

    func identify(
        anonymousId: AnonymousId,
        sourceId: SourceId,
        customData: [String: AnyHashable]
    ) async throws -> String? {
        let graphQLResult: GraphQLResult<ToldAPI.IdentifySourceAuthorByAnonymousIDMutation.Data>
        do {
            graphQLResult = try await apolloClient.performAsync(
                mutation: ToldAPI.IdentifySourceAuthorByAnonymousIDMutation(
                    anonymousID: anonymousId,
                    sourceID: sourceId,
                    customData: ToldAPI.JSON.init(_jsonValue: customData)
                )
            )
        } catch {
            throw NetworkError.apolloError(error)
        }
        return try graphQLResult.dataAssertNoError().identifySourceAuthorByAnonymousID
    }

    func trackIdentify(
        anonymousId: AnonymousId,
        sourceId: SourceId,
        primaryData: PrimaryEventData
    ) async throws {
        try await trackEvent(
            anonymousId: anonymousId,
            sourceId: sourceId,
            primaryData: primaryData,
            eventName: .identify
        )
    }

    func trackCustomEvent(
        anonymousId: AnonymousId,
        sourceId: SourceId,
        customName: String,
        customData: [String: AnyHashable],
        primaryData: PrimaryEventData
    ) async throws -> TrackEventResult {
        let graphQLResult: GraphQLResult<ToldAPI.TrackCustomEventMutation.Data>
        do {
            graphQLResult = try await apolloClient.performAsync(
                mutation:  ToldAPI.TrackCustomEventMutation(
                    anonymousId: .some(anonymousId),
                    name: .case(.customEvent),
                    sourceId: sourceId,
                    primaryData: .some(ToldAPI.PrimaryEventDataInput(primaryData)),
                    customName: customName,
                    customData: .some(ToldAPI.JSON(_jsonValue: customData))
                )
            )
        } catch {
            throw NetworkError.apolloError(error)
        }
        let data: ToldAPI.TrackCustomEventMutation.Data = try graphQLResult.dataAssertNoError()

        if let triggerInfo = data.addCustomEvent?.triggerInfo, triggerInfo.activate == true {
            guard let surveyId = triggerInfo.surveyId else {
                throw NetworkError.unexpected
            }
            return .triggerOn(
                surveyId: surveyId,
                delay: triggerInfo.activateParam?.delay
            )
        } else {
            return .noTrigger
        }
    }

    func trackChangePage(
        anonymousId: AnonymousId,
        sourceId: SourceId,
        primaryData: PrimaryEventData
    ) async throws -> TrackEventResult {
        let data: ToldAPI.TrackEventMutation.Data = try await trackEvent(
            anonymousId: anonymousId,
            sourceId: sourceId,
            primaryData: primaryData,
            eventName: .changePage
        )
        if let triggerInfo = data.addEvent?.triggerInfo, triggerInfo.activate == true {
            guard let surveyId = triggerInfo.surveyId else {
                throw NetworkError.unexpected
            }
            return .triggerOn(
                surveyId: surveyId,
                delay: triggerInfo.activateParam?.delay
            )
        } else {
            return .noTrigger
        }
    }

    func trackCloseSurvey(
        anonymousId: AnonymousId,
        sourceId: SourceId,
        primaryData: PrimaryEventData
    ) async throws {
        try await trackEvent(
            anonymousId: anonymousId,
            sourceId: sourceId,
            primaryData: primaryData,
            eventName: .closeSurvey
        )
    }

    func reset(
        anonymousId: AnonymousId,
        sourceId: SourceId,
        primaryData: PrimaryEventData
    ) async throws {
        try await trackEvent(
            anonymousId: anonymousId,
            sourceId: sourceId,
            primaryData: primaryData,
            eventName: .reset
        )
    }

    @discardableResult
    private func trackEvent(
        anonymousId: AnonymousId,
        sourceId: SourceId,
        primaryData: PrimaryEventData,
        eventName: ToldAPI.EventName
    ) async throws -> ToldAPI.TrackEventMutation.Data {
        let graphQLResult:  GraphQLResult<ToldAPI.TrackEventMutation.Data>
        do {
            graphQLResult = try await apolloClient.performAsync(
                mutation: ToldAPI.TrackEventMutation(
                    anonymousId: .some(anonymousId),
                    name: .case(eventName),
                    sourceId: sourceId,
                    primaryData: .some(
                        ToldAPI.PrimaryEventDataInput(primaryData)
                    )
                )
            )
        } catch {
            throw NetworkError.apolloError(error)
        }
        return try graphQLResult.dataAssertNoError()
    }
}
