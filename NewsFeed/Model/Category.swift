//
//  Category.swift
//  NewsFeed
//
//  Created by radioshaolin on 18.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

enum Category: Int {
    case all = 0
    case business
    case entertainment
    case gaming
    case general
    case music
    case politics
    case scienceAndNature
    case sport
    case technology
    
    var description : String {
        get {
            switch(self) {
            case .all:
                return ""
            case .business:
                return "business"
            case .entertainment:
                return "entertainment"
            case .gaming:
                return "gaming"
            case .general:
                return "general"
            case .music:
                return "music"
            case .politics:
                return "politics"
            case .scienceAndNature:
                return "science-and-nature"
            case .sport:
                return "sport"
            case .technology:
                return "technology"
            }
        }
    }
    
}
