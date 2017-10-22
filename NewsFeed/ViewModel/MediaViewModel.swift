//
//  ArticleSourceViewModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct MediaViewModel {
    
    let mediaData: Media
    
    var name: String {
        return mediaData.name.uppercased()
    }
    var description: String {
        return mediaData.description
    }
    
    init(mediaData: Media) {
        self.mediaData = mediaData
    }
}

