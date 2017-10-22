//
//  ArticleCell.swift
//  NewsFeed
//
//  Created by Radio Shaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
    
    static let cellId = "mediaCellID"
    
    let sourceNameLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
        return l
    }()
    
    let descriptionLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        l.textAlignment = .left
        l.textColor = .white
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayMediaInCell(using viewModel: MediaViewModel) {
        sourceNameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
    }
    
    func setUpViews() {
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = #colorLiteral(red: 0.2289139375, green: 0.2471015505, blue: 0.2744348894, alpha: 1)
        selectedBackgroundView = selectedBackground
        addSubview(sourceNameLabel)
        sourceNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        sourceNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sourceNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        sourceNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: sourceNameLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: sourceNameLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: sourceNameLabel.rightAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        
        
    }
}



