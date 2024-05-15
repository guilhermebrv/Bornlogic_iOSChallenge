//
//  APIEndpointParams.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 15/05/2024.
//

import Foundation

enum EndpointBase {
    case newsAPI
    
    var url: String {
        switch self {
        case .newsAPI:
            return "https://newsapi.org"
        }
    }
}

enum EndpointNewsType {
    case topHeadlines
    case everything
    
    var option: String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .everything:
            return "/v2/everything"
        }
    }
}

enum EndpointCountries {
    case argentina, australia, brazil, canada, china, france, germany, italy, japan, mexico, portugal, unitedKingdom, unitedStates
    
    var param: String {
        "country"
    }
    
    var option: String {
        switch self {
        case .argentina:
            return "ar"
        case .australia:
            return "au"
        case .brazil:
            return "br"
        case .canada:
            return "ca"
        case .china:
            return "cn"
        case .france:
            return "fr"
        case .germany:
            return "de"
        case .italy:
            return "it"
        case .japan:
            return "jp"
        case .mexico:
            return "mx"
        case .portugal:
            return "pt"
        case .unitedKingdom:
            return "gb"
        case .unitedStates:
            return "us"
        }
    }
}

enum EndpointCategory {
    case business, entertainment, general, health, science, sports, technology
    
    var param: String {
        "category"
    }
    
    var option: String {
        switch self {
        case .business:
            return "business"
        case .entertainment:
            return "entertainment"
        case .general:
            return "general"
        case .health:
            return "health"
        case .science:
            return "science"
        case .sports:
            return "sports"
        case .technology:
            return "technology"
        }
    }
}
