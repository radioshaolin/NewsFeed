//
//  ArticleCell.swift
//  NewsFeed
//
//  Created by Radio Shaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {
    
    static let cellId = "articleCellId"
    
    let articleImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 40
        iv.backgroundColor = #colorLiteral(red: 1, green: 0.3864146769, blue: 0.4975627065, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
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
    
    let authorLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "HelveticaNeue-LightItalic", size: 14)
        l.textAlignment = .right
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
    
    func displayArticleInCell(using viewModel: ArticleViewModel) {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        articleImage.loadImageUsingCacheWithURLString(viewModel.urlToImage, defaultImage: nil) { (bool) in
            // perform action if needed
        }
    }
    
    func setUpViews() {
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = #colorLiteral(red: 0.2289139375, green: 0.2471015505, blue: 0.2744348894, alpha: 1)
        selectedBackgroundView = selectedBackground
        addSubview(articleImage)
        articleImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        articleImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        articleImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        articleImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        addSubview(titleLabel)
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: articleImage.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        
        addSubview(authorLabel)
        authorLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5).isActive = true
    }
}


