//
//  MediaFetchService.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

class MediaFetchService: Gettable {
    //the associated type is inferred by <[Media?]>
    typealias MediaCompletionHandler = (Result<[Media?]>) -> ()
    
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
    func get(completion: @escaping MediaCompletionHandler) {
        
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
                    //parsing the Json response
                    guard let mediaJSONFeed = json["sources"] as? [[String: AnyObject]]
                    else {
                            completion(.error(.jsonParsingFailure))
                            return
                    }
                    //maping the array and create Source objects
                    let mediaArray = mediaJSONFeed.map { rawSource in Media(json: rawSource)}
                    completion(.success(mediaArray))
                }
            }
        }
        task.resume()
    }
}
