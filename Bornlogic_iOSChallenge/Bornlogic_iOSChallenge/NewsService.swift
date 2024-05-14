//
//  NewsService.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import Foundation

struct NewsService: NewsServiceDelegate, DataParsingDelegate {
    let apiKey = APIKeyManager.shared.getApiKey()
    
    func fetchData() async throws -> NewsData? {
        guard let apiKey else {
            print("Need an API key to perform request")
            return nil
        }
        
        let endpoint = "https://newsapi.org/v2/everything?q=taylor&from=2024-04-14&language=en&sortBy=publishedAt&apiKey=\(apiKey)"
        
        guard let url = URL(string: endpoint) else { throw NewsError.invalidURL(endpoint) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else { throw NewsError.invalidResponse }

        return try decodeData(data)
    }
    
    func decodeData(_ data: Data) throws -> NewsData? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode(NewsData.self, from: data)
        } catch {
            throw NewsError.invalidData
        }
    }

}
