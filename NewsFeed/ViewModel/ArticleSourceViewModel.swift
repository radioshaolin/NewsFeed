//
//  ArticleSourceViewModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct ArticleSourceViewModel {
    let status: String
    let sourceId: String
    let sortBy: String
    let articles: [ArticleViewModel]

    init(model: ArticleSource) {
        self.status = model.status
        self.sourceId = model.sourceId
        self.sortBy = model.sortBy
        self.articles = model.articles.map { article in
            ArticleViewModel(model: article)
        }
    }
}
