//
//  Result.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(NewsApiError)
}

