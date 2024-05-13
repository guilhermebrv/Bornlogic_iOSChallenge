//
//  NewsService.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import Foundation 

protocol NewsServiceProtocol {
    func fetchData() async throws -> NewsData?
}

enum NewsError: Error {
    case invalidURL(_ urlString: String)
    case invalidResponse
    case invalidData
}

class NewsService: NewsServiceProtocol {
    let apiKey = APIKeyManager.shared.getApiKey()
    
    func fetchData() async throws -> NewsData? {
        guard let apiKey else {
            print("Need an API key to perform request")
            return nil
        }
        
        let endpoint = "https://newsapi.org/v2/everything?q=taylor-swift&from=2024-04-13&language=en&sortBy=publishedAt&apiKey=\(apiKey)"
        
        guard let url = URL(string: endpoint) else { throw NewsError.invalidURL(endpoint) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else { throw NewsError.invalidResponse }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Received JSON string: \(jsonString)")
        }
        
        return try decodeData(data)
    }
    
    private func decodeData(_ data: Data) throws -> NewsData? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode(NewsData.self, from: data)
        } catch {
            throw NewsError.invalidData
        }
    }

}
