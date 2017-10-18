//
//  RootVC.swift
//  NewsFeed
//
//  Created by Radio Shaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation
import UIKit

class RootVC: UITableViewController {
    
    // View which contains the loading text and the spinner
    private let loadingView = UIView()
    // Spinner shown during load the TableView
    private let spinner = UIActivityIndicatorView()
    // Text shown during load the TableView
    private let loadingLabel = UILabel()
    // Dropdown menu for filtering categories
    private var menuView: BTNavigationDropdownMenu!
    // CellId string for initializing and using SourceCell
    private let cellID = "sourceCellID"
    // Array of categories for showing in Fitlering Menu
    private let category = ["All Categories", "Business", "Entertainment", "Gaming", "General", "Music", "Politics", "Science And Nature", "Sport", "Technology"]
    // Fetching Source Service
    private let sourceFetchService: SourceService
    // Primary/backup dataSouce of downloaded news sources
    private var sourcesArray = [Source]()
    // Current dataSouce used for updating TableView
    private var filteredSourceArray = [Source]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    init() {
        self.sourceFetchService = SourceService(downloader: JSONDownloader())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarSetUp()
        tableViewSetUp()
        setLoadingScreen()
        filteringMenuSetUp()
        getData(fromService: sourceFetchService)
    }
    
    private func getData<S: Gettable>(fromService service: S) where S.T == Array<Source?> {
        service.get { [weak self] (result) in
            switch result {
            case .Success(let sources):
                self?.sourcesArray = sources.flatMap { $0 }
                self?.sourceFilter(index: 0)
                self?.removeLoadingScreen()
            case .Error(let error):
                print(error)
            }
        }
    }
    
    private func sourceFilter(index: Int) {
        guard let chosenCategory = Category(rawValue: index)?.description else { return }
        if index == 0 {
            self.filteredSourceArray = sourcesArray
        } else {
            self.filteredSourceArray = sourcesArray.filter({ (source) -> Bool in
                source.category == chosenCategory
            })
        }
    }
    
    
    private func navigationBarSetUp () {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    private func tableViewSetUp() {
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.register(SourceCell.self, forCellReuseIdentifier: cellID)
    }

    private func filteringMenuSetUp() {
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(0), items: self.category)
        // Other way to initialize with alternative Menu naming:
        //        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("All News Sources"), items: self.category)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Helvetica-Neue-bold", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            self.sourceFilter(index: indexPath)
        }
        navigationItem.titleView = menuView
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! SourceCell
        let source = filteredSourceArray[indexPath.row]
        let sourceViewModel = SourceViewModel(model: source)
        cell.displaySourceInCell(using: sourceViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSourceArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sourceId = filteredSourceArray[indexPath.row].sourceId
        let sourceName = filteredSourceArray[indexPath.row].name
        let destinationVC = ArticlesSourceVC(sourceId: sourceId, sourceName: sourceName)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }

}
