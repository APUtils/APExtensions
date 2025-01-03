//
//  URL+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 11/1/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation
import UIKit

public extension URL {
    
    /// File name without extension. Nil if it's directory.
    @available(iOS 9.0, *)
    var fileName: String? {
        guard !hasDirectoryPath else { return nil }
        
        return String(lastPathComponent.split(separator: ".")[0])
    }
    
    /// File name with extension. Nil if it's directory.
    @available(iOS 9.0, *)
    var fullFileName: String? {
        guard !hasDirectoryPath else { return nil }
        
        return lastPathComponent
    }
    
    /// Returns directory URL
    @available(iOS 9.0, *)
    var directory: URL {
        if isLocalDirectory {
            return self
        } else {
            return deletingLastPathComponent()
        }
    }
    /// Check if it's URL to local directory
    @available(iOS 9.0, *)
    var isLocalDirectory: Bool {
        return isFileURL && hasDirectoryPath
    }
    
    /// Check if it's URL to local file
    @available(iOS 9.0, *)
    var isLocalFile: Bool {
        return isFileURL && !hasDirectoryPath
    }
    
    /// Try to init UIImage from URL to check if this URL points to an image.
    @available(iOS 9.0, *)
    var isImageUrl: Bool {
        guard isFileURL && !hasDirectoryPath else { return false }
        
        return UIImage(contentsOfFile: path) != nil
    }
    
    /// Appends path component and prevents double slashes if URL has trailing slash and path component has leading slash.
    func smartAppendingPathComponent(_ pathComponent: String, isDirectory: Bool = false) -> URL {
        guard !pathComponent.isEmpty else { return self }
        
        var pathComponent = pathComponent
        if pathComponent.first == "/" {
            pathComponent = String(pathComponent.dropFirst())
        }
        
        return appendingPathComponent(pathComponent, isDirectory: isDirectory)
    }
}

// ******************************* MARK: - Comparable

extension URL: @retroactive Comparable {
    public static func < (lhs: URL, rhs: URL) -> Bool {
        lhs.relativeString < rhs.relativeString
    }
}
