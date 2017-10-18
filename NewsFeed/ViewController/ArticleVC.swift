//
//  ArticleVC.swift
//  NewsFeed
//
//  Created by radioshaolin on 17.10.17.
//  Copyright © 2017 Radio Shaolin. All rights reserved.
//

import Foundation
import UIKit

class ArticleVC: UIViewController, UIWebViewDelegate {
    
    var url: String = String()
    let webView: UIWebView = {
        let wV = UIWebView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        return wV
    }()
    var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.hidesWhenStopped = true
        aiv.color = .black
        return aiv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(activityIndicatorView)
        setupActivityViewConstraints()
        webView.delegate = self
        pageLoad(url: url)
    }
    
    func pageLoad(url: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let url = URL(string: self.url)
            if let unwrappedURL = url {
                let request = URLRequest(url: unwrappedURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30.0)
                let session = URLSession.shared
                let task = session.dataTask(with: request) { (data, response, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.webView.loadRequest(request)
                        }
                    } else {
                        print("ERROR: \(String(describing: error))")
                    }
                }
                task.resume()
            }
        }
    }
    
    private func setupActivityViewConstraints() {
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicatorView.startAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicatorView.stopAnimating()
    }
    
}
