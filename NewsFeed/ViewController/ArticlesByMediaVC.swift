//
//  ArticleSourceVC.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation
import UIKit

class ArticlesByMediaVC: UITableViewController {
    
    var viewModel: ArticlesByMediaViewModel
    private var mediaName = ""
    
    init(sourceId: String, mediaName: String) {
        self.mediaName = mediaName
        self.viewModel = ArticlesByMediaViewModel(model: ArticlesModelFactory.defaultModel(sourceId: sourceId))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetUp()
        navigationControllerViewSetUp()
        loadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.getArticleCell(with: tableView, by: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfArticles
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = viewModel.getDestinationArticleVC(by: indexPath.row)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension ArticlesByMediaVC {
    
    private func loadData() {
        viewModel.articlesModel.getData { [weak self] (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func navigationControllerViewSetUp() {
        navigationItem.title = "\(mediaName) Articles"
    }
    
    private func tableViewSetUp() {
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.cellId)
    }
    
}
