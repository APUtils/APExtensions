//
//  FileManager+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/12/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension FileManager {
    /// Checks if FILE exists at URL
    @available(iOS 9.0, *)
    public func fileExists(at url: URL) -> Bool {
        guard url.isFileURL && !url.hasDirectoryPath else { return false }
        
        var isDirectory: ObjCBool = ObjCBool(false)
        let fileExists = self.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        return fileExists && !isDirectory.boolValue
    }
    
    /// Checks if directory exists at URL
    @available(iOS 9.0, *)
    public func directoryExists(at url: URL) -> Bool {
        guard url.isFileURL && url.hasDirectoryPath else { return false }
        
        var isDirectory: ObjCBool = ObjCBool(false)
        let fileExists = self.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        return fileExists && isDirectory.boolValue
    }
}
