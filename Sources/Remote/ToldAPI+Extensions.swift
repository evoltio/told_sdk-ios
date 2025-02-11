//
//  ToldAPI+Extensions.swift
//  Told
//
//  Created by Jérémy Magnier on 15/01/2025.
//

import Apollo
import Foundation

extension ApolloClient {
    func fetchAsync<Query: GraphQLQuery>(
      query: Query,
      cachePolicy: CachePolicy = .default,
      contextIdentifier: UUID? = nil,
      context: (any RequestContext)? = nil,
      queue: DispatchQueue = .main
    ) async throws -> GraphQLResult<Query.Data> {
        var cancellable: (any Cancellable)?
        return try await withTaskCancellationHandler {
            try await withUnsafeThrowingContinuation { continuation in
                cancellable = fetch(
                    query: query,
                    cachePolicy: cachePolicy,
                    contextIdentifier: contextIdentifier,
                    context: context,
                    queue: queue,
                    resultHandler: { result in
                        continuation.resume(with: result)
                    }
                )
            }
        } onCancel: { [cancellable] in
            cancellable?.cancel()
        }
    }

    func performAsync<Mutation: GraphQLMutation>(
        mutation: Mutation,
        publishResultToStore: Bool = true,
        context: (any RequestContext)? = nil,
        queue: DispatchQueue = .main
    ) async throws -> GraphQLResult<Mutation.Data> {
        var cancellable: (any Cancellable)?
        return try await withTaskCancellationHandler {
            try await withUnsafeThrowingContinuation { continuation in
                cancellable = perform(
                    mutation: mutation,
                    publishResultToStore: publishResultToStore,
                    context: context,
                    queue: queue,
                    resultHandler: { result in
                        continuation.resume(with: result)
                    }
                )
            }
        } onCancel: { [cancellable] in
            cancellable?.cancel()
        }
    }
}

extension GraphQLResult {
    func dataAssertNoError() throws(NetworkError) -> Data {
        if let error = errors?.first {
            throw NetworkError.graphQL(error)
        }
        return try dataOrThrows()
    }

    func dataOrThrows() throws(NetworkError) -> Data {
        guard let data else { throw NetworkError.noData }
        return data
    }
}

extension ToldAPI.PrimaryEventDataInput {
    init(
        _ primaryEventDataInput: PrimaryEventData
    ) {
        self.init(
            language: primaryEventDataInput.language ?? .none,
            deviceType: .some(.case(.phone)),
            os: .some(.case(.ios)),
            version: primaryEventDataInput.version ?? .none,
            pageName: primaryEventDataInput.pageName ?? .none,
            survey: primaryEventDataInput.survey ?? .none
        )
    }
}
