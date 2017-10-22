//
//  JSONDownloader.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

class JSONDownloader {
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (Result<JSON>) -> ()
    
    let apiKey = "8b75f6c388c0469e86a09dc8323b152a"
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.error(.requestFailed))
                return
            }
            if 200 ... 299 ~= httpResponse.statusCode {
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
                            DispatchQueue.global(qos: .userInteractive).async {
                                completion(.success(json))
                            }
                        }
                    } catch {
                        completion(.error(.jsonConversionFailure))
                    }
                } else {
                    completion(.error(.invalidData))
                }
            } else {
                completion(.error(.responseUnsuccessful))
            }
        }
        return task
    }
}


