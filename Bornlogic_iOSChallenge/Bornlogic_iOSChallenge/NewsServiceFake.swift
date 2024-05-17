//
//  NewsServiceFake.swift
//  Bornlogic_iOSChallengeTests
//
//  Created by Guilherme Viana on 15/05/2024.
//

import UIKit

class NewsServiceFake: NewsServiceDelegate {
    var errorToThrow: NewsError?
    
    func fetchData(for newsType: EndpointNewsType?, country: EndpointCountries?, category: EndpointCategory?) async throws -> NewsData? {
        if let error = errorToThrow {
            throw error
        }
        return nil
    }
}
