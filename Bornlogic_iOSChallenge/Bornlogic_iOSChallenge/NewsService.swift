//
//  NewsService.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import Foundation

struct NewsService: NewsServiceDelegate {    
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(for newsType: EndpointNewsType?, country: EndpointCountries?, category: EndpointCategory?) async throws -> NewsData? {
        let apiKey = APIKeyManager.shared.getApiKey()
        let endpointURL = APIEndpointHandler().getEndpointURL(for: newsType, country: country, category: category, with: apiKey)

        guard let endpointURL else { throw NewsError.invalidURL }
        
        let (data, response) = try await session.data(from: endpointURL)
                
        guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else { throw NewsError.invalidResponse }
        
        return try DataParser().decodeData(data)
    }
}
