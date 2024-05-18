//
//  ValidNewsData.swift
//  Bornlogic_iOSChallenge
//
//  Created by Guilherme Viana on 18/05/2024.
//

import Foundation

struct ValidNewsData {
    static let articles = [Article(source: Source(id: "id", name: "name"),
                                   author: "author",
                                   title: "title",
                                   description: "description",
                                   url: "url",
                                   urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2152436289.jpg?c=16x9&q=w_800,c_fill",
                                   publishedAt: Date.now,
                                   content: "content"),
                           Article(source: Source(id: "id", name: "name"),
                                               author: "author",
                                               title: "title",
                                               description: "description",
                                               url: "url",
                                               urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2152436289.jpg?c=16x9&q=w_800,c_fill",
                                               publishedAt: Date.now,
                                               content: "content"),
                           Article(source: Source(id: "id", name: "name"),
                                               author: "[Removed]",
                                               title: "[Removed]",
                                               description: "[Removed]",
                                               url: "[Removed]",
                                               urlToImage: nil,
                                               publishedAt: Date.now,
                                               content: "[Removed]"),
                           Article(source: Source(id: "id", name: "name"),
                                               author: "author",
                                               title: "title",
                                               description: "description",
                                               url: "url",
                                               urlToImage: "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2152436289.jpg?c=16x9&q=w_800,c_fill",
                                               publishedAt: Date.now,
                                               content: "content")]
}
