//
//  SourceService.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

struct SourceService: Gettable {
    //the associated type is inferred by <[Source?]>
    typealias SourcesCompletionHandler = (Result<[Source?]>) -> ()
    
    private let downloader: JSONDownloader
    private var apiUrl: String {
        get {
            return "https://newsapi.org/v1/sources"
        }
    }
    
    init(downloader: JSONDownloader) {
        self.downloader = downloader
    }
    
    //protocol required function
    func get(completion: @escaping SourcesCompletionHandler) {
        
        guard let url = URL(string: self.apiUrl) else {
            completion(.Error(.invalidURL))
            return
        }
        //using the JSONDownloader function
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    //parsing the Json response
                    guard let sourcesJSONFeed = json["sources"] as? [[String: AnyObject]]
                    else {
                            completion(.Error(.jsonParsingFailure))
                            return
                    }
                    //maping the array and create Source objects
                    let sourceArray = sourcesJSONFeed.map { rawSource in Source(json: rawSource)}
                    completion(.Success(sourceArray))
                }
            }
        }
        task.resume()
    }
}
