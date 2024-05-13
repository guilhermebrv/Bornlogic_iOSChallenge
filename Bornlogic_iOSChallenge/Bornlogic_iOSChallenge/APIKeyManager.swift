//
//  APIKeyManager.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import Foundation

class APIKeyManager {
    static let shared = APIKeyManager()
    private var apiKey: String?

    private init() {
        loadApiKey()
    }

    private func loadApiKey() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            apiKey = dict["APIKey"] as? String
        }
    }

    func getApiKey() -> String? {
        return apiKey
    }
}
