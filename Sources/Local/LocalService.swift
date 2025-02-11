//
//  LocalService.swift
//  Told
//
//  Created by Jérémy Magnier on 17/01/2025.
//

import Foundation

extension LocalService {
    struct Key: RawRepresentable {
        let rawValue: String

        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension LocalService.Key {
    static let language: Self = .init(rawValue: "language")
    static let lastPage: Self = .init(rawValue: "lastPage")
    static let anonymousId: Self = .init(rawValue: "anonymousId")
    static let currentSurvey: Self = .init(rawValue: "surveyId")
}

final class LocalService {
    private let userDefault: UserDefaults

    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }

    func set(_ value: String, for key: LocalService.Key) {
        userDefault.set(value, forKey: key.rawValue)
    }

    func get(_ key: LocalService.Key) -> String? {
        userDefault.string(forKey: key.rawValue)
    }

    func remove(_ key: LocalService.Key) {
        userDefault.removeObject(forKey: key.rawValue)
    }
}
