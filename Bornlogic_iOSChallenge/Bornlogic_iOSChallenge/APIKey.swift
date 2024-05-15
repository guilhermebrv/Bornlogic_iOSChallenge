//
//  APIKey.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import Foundation

struct APIKeyManager {
    static let shared = APIKeyManager()
    private let apiKey: String = "47254af115e34999a5a86b9519eed9b4"

    func getApiKey() -> String {
        return apiKey
    }
}
