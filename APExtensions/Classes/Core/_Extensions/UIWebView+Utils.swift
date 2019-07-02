//
//  UIWebView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/20/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIWebView {
    /// Loads url from given string if possible
    func load(urlString: String) {
        load(url: URL(string: urlString))
    }
    
    /// Loads url
    func load(url: URL?) {
        guard let url = url else { return }
        
        let request = URLRequest(url: url)
        loadRequest(request)
    }
    
    /// Shows empty page
    func clear() {
        load(urlString: "about:blank")
    }
}
