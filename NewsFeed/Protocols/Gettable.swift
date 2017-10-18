//
//  Gettable.swift
//  NewsFeed
//
//  Created by Radio Shaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

protocol Gettable {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> Void)
}
