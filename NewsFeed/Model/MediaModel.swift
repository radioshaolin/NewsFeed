//
//  MediaModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 20.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation

protocol MediaModel {
    typealias MediaCompletionHandler = (Result<[Media?]>) -> ()
    var entries: [Media] { get }
    func getData(completion: @escaping MediaCompletionHandler)
}

class MediaModelImpl: MediaModel {

    private let requestsManager: MediaFetchService
    private(set) var entries: [Media]

    init(requestsManager: MediaFetchService) {
        self.requestsManager = requestsManager
        self.entries = []
    }
    
    func getData(completion: @escaping MediaCompletionHandler) {
        requestsManager.get { [weak self] (result) in
            switch result {
            case .success(let media):
                self?.entries = media.flatMap { $0 }
                completion(.success(media))
            case .error:
                completion(.error(.failureToGetDataInModel))
            }
        }
    }
    
}

class MediaModelFactory {
    static func defaultModel() -> MediaModel {
        return MediaModelImpl(requestsManager: MediaFetchService(downloader: JSONDownloader()))
    }
}

