//
//  MediaSource.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct ArticlesSource {
    let status: String
    let sourceId: String
    let sortBy: String
    let articles: [Article]
}

extension ArticlesSource {
    struct Key  {
        static let status = "status"
        static let sourceId = "source"
        static let sortBy = "sortBy"
        static let articles = "articles"
    }
    //failable initializer
    init?(json: [String: AnyObject]) {
        guard let status = json[Key.status] as? String,
            let sourceId = json[Key.sourceId] as? String,
            let sortBy = json[Key.sortBy] as? String,
            let articles = json[Key.articles] as? [Article]
            else { return nil }
        self.status = status
        self.sourceId = sourceId
        self.sortBy = sortBy
        self.articles = articles
    }
}

