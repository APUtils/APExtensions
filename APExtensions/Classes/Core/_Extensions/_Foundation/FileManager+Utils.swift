//
//  FileManager+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/12/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

#if COCOAPODS
import LogsManager
#else
import RoutableLogger
#endif

public extension FileManager {
    /// Checks if FILE exists at URL
    @available(iOS 9.0, *)
    func fileExists(at url: URL) -> Bool {
        guard url.isFileURL && !url.hasDirectoryPath else { return false }
        
        var isDirectory: ObjCBool = ObjCBool(false)
        let itemExists = self.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        return itemExists && !isDirectory.boolValue
    }
    
    /// Checks if directory exists at URL
    @available(iOS 9.0, *)
    func directoryExists(at url: URL) -> Bool {
        guard url.isFileURL && url.hasDirectoryPath else { return false }
        
        var isDirectory: ObjCBool = ObjCBool(false)
        let itemExists = self.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        return itemExists && isDirectory.boolValue
    }
    
    @available(iOS 9.0, *)
    func itemExists(at url: URL) -> Bool {
        let isItemDirectory = url.hasDirectoryPath
        
        var isDirectory: ObjCBool = ObjCBool(false)
        let itemExists = self.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        if isItemDirectory {
            return isDirectory.boolValue && itemExists
        } else {
            return !isDirectory.boolValue && itemExists
        }
    }
}

// ******************************* MARK: - Disk Space

public extension FileManager {
    
    /// Returns formatted string containing free disk space size.
    var freeDiskSpace: String {
        ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: .file)
    }
    
    fileprivate var freeDiskSpaceInBytes: Int64 {
        do {
            let systemAttributes = try attributesOfFileSystem(forPath: NSHomeDirectory())
            let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
            return freeSpace ?? 0
        } catch {
            RoutableLogger.logError("Unable to get free space", data: ["home": NSHomeDirectory()])
            return 0
        }
    }
    
}
