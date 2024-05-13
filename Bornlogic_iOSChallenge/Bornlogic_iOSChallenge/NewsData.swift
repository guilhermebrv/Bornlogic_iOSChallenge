//
//  NewsData.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 13/05/2024.
//

import Foundation

struct NewsData: Decodable {
    var articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String
}

struct Source: Decodable {
    let id: String?
    let name: String
}
