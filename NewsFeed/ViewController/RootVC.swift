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
    
    var viewModel: RootViewModel
    private var menuView: BTNavigationDropdownMenu!
    
    init() {
        self.viewModel = RootViewModel(mediaModel: MediaModelFactory.defaultModel())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetUp()
        tableViewSetUp()
        filteringMenuSetUp()
        loadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.getMediaCell(with: tableView, by: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumbersOfMedia
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = viewModel.getArticlesByMediaVC(by: indexPath.row)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}

extension RootVC {
    
    private func loadData() {
        viewModel.mediaModel.getData { [weak self] (result) in
            switch result {
            case .success:
                self?.viewModel.filteringByMedia(withIndex: 0, completion: {
                    self?.tableView.reloadData()
                })
            case .error(let error):
                print(error)
            }
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
        tableView.register(MediaCell.self, forCellReuseIdentifier: MediaCell.cellId)
    }
    
    private func filteringMenuSetUp() {
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(0), items: self.viewModel.category)
        menuView.viewSetUp()
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            self.viewModel.filteringByMedia(withIndex: indexPath, completion: {
                self.tableView.reloadData()
            })
        }
        navigationItem.titleView = menuView
    }
    
}

