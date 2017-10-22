//
//  ArticlesModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 20.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//


import Foundation

protocol ArticlesModel {
    typealias ArticlesCompletionHandler = (Result<[Article?]>) -> ()
    var entries: [Article] { get }
    func getData(completion: @escaping ArticlesCompletionHandler)
}

class ArticlesModelImpl: ArticlesModel {
    
    private let requestsManager: ArticlesFetchService
    private(set) var entries: [Article]
    
    init(requestsManager: ArticlesFetchService) {
        self.requestsManager = requestsManager
        self.entries = []
    }
    
    func getData(completion: @escaping ArticlesCompletionHandler) {
        requestsManager.get { [weak self] (result) in
            switch result {
            case .success(let articles):
                self?.entries = articles.flatMap { $0 }
                completion(.success(articles))
            case .error:
                completion(.error(.failureToGetDataInModel))
            }
        }
    }
    
}

class ArticlesModelFactory {
    static func defaultModel(sourceId: String) -> ArticlesModel {
        let requestManager = ArticlesFetchService(sourceId: sourceId, downloader: JSONDownloader())
        return ArticlesModelImpl(requestsManager: requestManager)
    }
}


