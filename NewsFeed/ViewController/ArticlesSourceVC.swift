//
//  ArticleSourceVC.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation
import UIKit

class ArticlesSourceVC: UITableViewController {
    
    // View which contains the loading text and the spinner
    private let loadingView = UIView()
    // Spinner shown during load the TableView
    private let spinner = UIActivityIndicatorView()
    // Text shown during load the TableView
    private let loadingLabel = UILabel()
    // Fetching Article Service
    private let articlesFetchService: ArticlesService
    // Current dataSouce used for updating TableView
    private var articlesArray = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // CellId string for initializing and using ArticleCell
    private let articleCellID = "articleCellID"
    // String variables for constructing URL in ide ArticleService
    private var sourceId = ""
    private var sourceName = ""
    
    init(sourceId: String, sourceName: String) {
        self.articlesFetchService = ArticlesService(sourceId: sourceId, downloader: JSONDownloader())
        self.sourceName = sourceName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetUp()
        setLoadingScreen()
        getData(fromService: articlesFetchService)
        navigationControllerViewSetUp()
    }
    
    private func getData<S: Gettable>(fromService service: S) where S.T == Array<Article?> {
        service.get { [weak self] (result) in
            switch result {
            case .Success(let sources):
                self?.articlesArray = sources.flatMap { $0 }
                self?.removeLoadingScreen()
            case .Error(let error):
                print(error)
            }
        }
    }
    
    private func navigationControllerViewSetUp() {
        navigationItem.title = "\(sourceName) Articles"
    }
    
    private func tableViewSetUp() {
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: articleCellID)
    }
    
    private func setLoadingScreen() {
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        // Sets loading text
        loadingLabel.textColor = .white
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        // Sets spinner
        spinner.activityIndicatorViewStyle = .white
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        tableView.addSubview(loadingView)
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellID) as! ArticleCell
        let article = articlesArray[indexPath.row]
        let articleViewModel = ArticleViewModel(model: article)
        cell.displayArticleInCell(using: articleViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = ArticleVC()
        destinationVC.url = articlesArray[indexPath.row].url
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

