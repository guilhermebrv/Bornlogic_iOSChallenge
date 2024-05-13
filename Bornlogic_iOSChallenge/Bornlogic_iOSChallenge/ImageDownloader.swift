//
//  ImageDownloader.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import UIKit

enum ImageError: Error {
    case invalidURL(_ urlString: String)
    case invalidResponse
    case invalidData
}

struct ImageDownloader {
    func downloadImageAsync(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                // TODO: add error handling
                return nil
            }
            return UIImage(data: data)
        } catch {
            // TODO: add error handling
            return nil
        }
    }
}
