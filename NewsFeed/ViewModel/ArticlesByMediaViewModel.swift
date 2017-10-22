//
//  SourceViewModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation
import UIKit

class ArticlesByMediaViewModel {
    
    let articlesModel: ArticlesModel
    
    init(model: ArticlesModel) {
        self.articlesModel = model
    }
    
    var getNumberOfArticles: Int {
        return articlesModel.entries.count
    }
    
    func getArticleViewModel(for index: Int) -> ArticleViewModel {
        return ArticleViewModel(articleData: articlesModel.entries[index])
    }
    
    func getDestinationArticleVC(by index: Int) -> ArticleVC {
        let articleVC = ArticleVC()
        let url = articlesModel.entries[index].url
        articleVC.url = url
        return articleVC
    }
    
    func getArticleCell(with tableView: UITableView, by index: Int) -> ArticleCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.cellId) as! ArticleCell
        let articleViewModel = self.getArticleViewModel(for: index)
        cell.displayArticleInCell(using: articleViewModel)
        return cell
    }
    
}

