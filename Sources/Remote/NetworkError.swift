//
//  NetworkError.swift
//  Told
//
//  Created by Jérémy Magnier on 15/01/2025.
//

enum NetworkError: Error {
    case noData
    case unexpected
    case apolloError(Error)
    case graphQL(Error)
}
