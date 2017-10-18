//
//  ArticleViewModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    let title: String
    let author: String
    let description: String
    let url: String
    let urlToImage: String
    
    init(model: Article) {
        self.title = model.title.uppercased()
        self.author = model.author
        self.description = model.description
        self.urlToImage = model.urlToImage
        self.url = model.url
    }
}
