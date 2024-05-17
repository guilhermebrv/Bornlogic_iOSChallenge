//
//  NetworkingProtocols.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 14/05/2024.
//

import UIKit


protocol NewsServiceDelegate {
    func fetchData(for newsType: EndpointNewsType?, country: EndpointCountries?, category: EndpointCategory?) async throws -> NewsData?
}

protocol EndpointDelegate {
    func getEndpointURL(for newsType: EndpointNewsType?, country: EndpointCountries?, category: EndpointCategory?, with apiKey: String) -> URL?
}

protocol DataParsingDelegate {
    func decodeData(_ data: Data) throws -> NewsData?
}

protocol ImageServiceDelegate {
    func downloadImageAsync(from urlString: String) async -> UIImage?
}
