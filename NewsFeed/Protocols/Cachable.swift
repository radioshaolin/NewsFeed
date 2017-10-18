//
//  Cachable.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation
import UIKit


private let imageCache = NSCache<NSString, UIImage>()

protocol Cachable {}

//UIImageview conforms to Cachable
extension UIImageView: Cachable {}

//Creating a protocol extension to add optional function implementations,
extension Cachable where Self: UIImageView {

    typealias SuccessCompletion = (Bool) -> ()
    
    func loadImageUsingCacheWithURLString(_ URLString: String, defaultImage: UIImage?, completion: @escaping SuccessCompletion) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
            }
            return
        }
        self.image = defaultImage
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else { return }
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                    }
                } else {
                    self.image = defaultImage
                }
            }).resume()
        } else {
            self.image = defaultImage
        }
    }
}
