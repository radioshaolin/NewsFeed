//
//  Source.swift
//  NewsFeed
//
//  Created by Radio Shaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct Source {
    let sourceId: String
    let name: String
    let description: String
    let category: String
    let language: String
    let country: String
    let sortBysAvailable: [String]
}

extension Source {
    struct Key  {
        static let sourceId = "id"
        static let name = "name"
        static let description = "description"
        static let category = "category"
        static let language = "language"
        static let country = "country"
        static let sortBysAvailable = "sortBysAvailable"
    }
    //failable initializer
    init?(json: [String: AnyObject]) {
        guard let sourceId = json[Key.sourceId] as? String,
            let name = json[Key.name] as? String,
            let description = json[Key.description] as? String,
            let category = json[Key.category] as? String,
            let language = json[Key.language] as? String,
            let country = json[Key.country] as? String,
            let sortBysAvailable = json[Key.sortBysAvailable] as? [String]
            else { return nil }
        self.sourceId = sourceId
        self.name = name
        self.description = description
        self.category = category
        self.language = language
        self.country = country
        self.sortBysAvailable = sortBysAvailable
    }
}




