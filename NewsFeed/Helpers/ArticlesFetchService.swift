//
//  ArticleService.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation


struct ArticlesFetchService: Gettable {
    //the associated type is inferred by <[Article?]>
    typealias CurrentArticleCompletionHandler = (Result<[Article?]>) -> ()
    
    private let downloader: JSONDownloader
    private var sourceId = ""
    private var apiUrl: String {
        get {
            return "https://newsapi.org/v1/articles?source=\(sourceId)&apiKey=\(downloader.apiKey)"
        }
    }
    
    init(sourceId: String, downloader: JSONDownloader) {
        self.sourceId = sourceId
        self.downloader = downloader
    }
    //protocol required function
    func get(completion: @escaping CurrentArticleCompletionHandler) {
        
        guard let url = URL(string: self.apiUrl) else {
            completion(.error(.invalidURL))
            return
        }
        //using the JSONDownloader function
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 5.0)
        let task = downloader.jsonTask(with: request) { (result) in
            DispatchQueue.global().async {
                switch result {
                case .error(let error):
                    completion(.error(error))
                    return
                case .success(let json):
                    guard let articlesJSONFeed = json["articles"] as? [[String: AnyObject]]
                    else {
                        completion(.error(.jsonParsingFailure))
                        return
                    }
                    //maping the array and create Media objects
                    let articlesArray = articlesJSONFeed.map{Article(json: $0)}
                    completion(.success(articlesArray))
                }
            }
        }
        task.resume()
    }
}

