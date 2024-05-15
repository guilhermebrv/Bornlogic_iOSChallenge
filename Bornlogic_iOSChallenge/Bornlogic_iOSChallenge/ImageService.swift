//
//  ImageService.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import UIKit

struct ImageService: ImageServiceDelegate {
    func downloadImageAsync(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return nil
            }
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
