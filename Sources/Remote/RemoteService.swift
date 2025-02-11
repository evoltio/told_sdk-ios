//
//  RemoteService.swift
//  Told
//
//  Created by Jérémy Magnier on 14/01/2025.
//

import Apollo
import Foundation

final class RemoteService {
    let apolloClient: ApolloClient

    init(serverURL: URL) {
        apolloClient = ApolloClient(url: serverURL)
    }
}
