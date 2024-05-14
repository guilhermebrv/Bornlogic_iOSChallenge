//
//  ErrorsEnum.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import Foundation

enum ImageError: Error {
    case invalidURL(_ urlString: String)
    case invalidResponse
    case invalidData
}

enum NewsError: Error {
    case invalidURL(_ urlString: String)
    case invalidResponse
    case invalidData
}
