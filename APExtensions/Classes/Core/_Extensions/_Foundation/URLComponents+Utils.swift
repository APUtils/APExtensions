//
//  URLComponents+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/30/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension URLComponents {
    /// Adds query item to other query items
    mutating func addQueryItem(_ item: URLQueryItem) {
        if queryItems == nil {
            queryItems = [item]
        } else {
            queryItems?.append(item)
        }
    }
}
