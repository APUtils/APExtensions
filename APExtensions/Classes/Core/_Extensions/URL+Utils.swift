//
//  URL+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 11/1/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension URL {
    /// File name without extension
    @available(iOS 9.0, *)
    public var fileName: String? {
        guard !hasDirectoryPath else { return nil }
        
        return String(lastPathComponent.split(separator: ".")[0])
    }
}
