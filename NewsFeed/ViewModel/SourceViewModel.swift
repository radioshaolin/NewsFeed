//
//  SourceViewModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct SourceViewModel {
    let sourceId: String
    let name: String
    let description: String
    let category: String
    let language: String
    let country: String
    let sortBysAvailable: [String]
    
    init(model: Source) {
        self.sourceId = model.sourceId
        self.name = model.name
        self.description = model.description
        self.category = model.category
        self.language = model.language
        self.country = model.country
        self.sortBysAvailable = model.sortBysAvailable
    }
}
