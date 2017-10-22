//
//  Article.swift
//  NewsFeed
//
//  Created by Radio Shaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct Article {
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
}

extension Article {
    struct Key {
        static let author = "author"
        static let title = "title"
        static let description = "description"
        static let url = "url"
        static let urlToImage = "urlToImage"
        static let publishedAt = "publishedAt"
    }
    //failable initializer
    init?(json: [String: AnyObject]) {
        guard let author = json[Key.author] as? String,
            let title = json[Key.title] as? String,
            let description = json[Key.description] as? String,
            let url = json[Key.url] as? String,
            let urlToImage = json[Key.urlToImage] as? String,
            let publishedAt = json[Key.publishedAt] as? String
            else { return nil }
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}

