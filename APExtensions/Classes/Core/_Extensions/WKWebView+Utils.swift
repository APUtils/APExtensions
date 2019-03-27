//
//  WKWebView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/20/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import WebKit


public extension WKWebView {
    /// Loads url from given string if possible
    func load(_ string: String) {
        guard let url = URL(string: string) else { return }
        
        load(url)
    }
    
    /// Loads url
    func load(_ url: URL) {
        load(URLRequest(url: url))
    }
    
    /// Shows empty page
    func clear() {
        load("about:blank")
    }
}
