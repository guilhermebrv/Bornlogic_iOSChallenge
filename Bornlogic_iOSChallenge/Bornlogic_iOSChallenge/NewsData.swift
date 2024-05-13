//
//  NewsData.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import Foundation

struct NewsData: Codable {
    var articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String
}

struct Source: Codable {
    let id: String?
    let name: String
}
