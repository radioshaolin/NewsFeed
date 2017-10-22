//
//  RootViewModel.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation
import UIKit

class RootViewModel {
    
    typealias TableViewUpdateCompletionHandler = () -> Void
    
    let mediaModel: MediaModel
    var filteredMedia: [Media]
    
    let category = ["All Categories", "Business", "Entertainment", "Gaming", "General", "Music", "Politics", "Science And Nature", "Sport", "Technology"]
    
    init(mediaModel: MediaModel) {
        self.filteredMedia = []
        self.mediaModel = mediaModel
    }
    
    var getNumbersOfMedia: Int {
        return filteredMedia.count
    }
    
    func getMediaViewModel(for index: Int) -> MediaViewModel {
        return MediaViewModel(mediaData: filteredMedia[index])
    }
    
    func getArticlesByMediaVC(by index: Int) -> ArticlesByMediaVC {
        let sourceId = filteredMedia[index].sourceId
        let mediaName = filteredMedia[index].name
        return ArticlesByMediaVC(sourceId: sourceId, mediaName: mediaName)
    }
    
    func filteringByMedia(withIndex index: Int, completion:@escaping TableViewUpdateCompletionHandler) {
        guard let chosenCategory = Category(rawValue: index)?.description else { return }
        switch index {
        case 0:
            self.filteredMedia = mediaModel.entries
        default:
            self.filteredMedia = mediaModel.entries.filter({ (media) -> Bool in
                media.category == chosenCategory })
        }
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func getMediaCell(with tableView: UITableView, by index: Int) -> MediaCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaCell.cellId) as! MediaCell
        let mediaViewModel = self.getMediaViewModel(for: index)
        cell.displayMediaInCell(using: mediaViewModel)
        return cell
    }
}

