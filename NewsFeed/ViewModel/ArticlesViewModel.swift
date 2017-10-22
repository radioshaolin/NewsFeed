//
//  ArticleViewModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    
    let articleData: Article
    
    var title: String {
        return articleData.title.uppercased()
    }
    
    var author: String {
        return articleData.author
    }
    
    var description: String {
        return articleData.description
    }
    
    var urlToImage: String {
        return articleData.urlToImage
    }
    
}

