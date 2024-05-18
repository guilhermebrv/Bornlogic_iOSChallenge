//
//  APIEndpointHandler.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 15/05/2024.
//

import Foundation

struct APIEndpointHandler: EndpointDelegate {

    func getEndpointURL(for newsType: EndpointNewsType?, country: EndpointCountries?, category: EndpointCategory?, with apiKey: String) -> URL? {
        let endpointBase = EndpointBase.newsAPI.url
        guard let endpointPath = newsType?.option else { return nil }

        var components = URLComponents(string: endpointBase + endpointPath)
        var queryItems = [URLQueryItem]()

        if let country {
            queryItems.append(URLQueryItem(name: country.param, value: country.option))
        }

        if let category {
            queryItems.append(URLQueryItem(name: category.param, value: category.option))
        }
        
        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        components?.queryItems = queryItems
        
        return components?.url
    }
}
