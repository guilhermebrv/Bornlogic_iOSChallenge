//
//  ErrorHandler.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import UIKit

enum NewsError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct ErrorHandler {
    public func errorMessage(for error: Error) -> String {
        if let newsError = error as? NewsError {
            switch newsError {
            case .invalidURL:
                return "The URL is invalid."
            case .invalidResponse:
                return "The response from the server was invalid."
            case .invalidData:
                return "The data received was corrupt or unreadable."
            }
        } else {
            return error.localizedDescription
        }
    }
}
