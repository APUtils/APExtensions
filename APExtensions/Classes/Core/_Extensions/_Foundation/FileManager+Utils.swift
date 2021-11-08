//
//  FileManager+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/12/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation
import RoutableLogger

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

// ******************************* MARK: - Safe

public extension FileManager {
    
    /// Removes item and logs error if unable
    func safeRemoveItemIfExists(atPath path: String, file: String = #file, function: String = #function, line: UInt = #line) {
        guard fileExists(atPath: path) else { return }
        
        do {
            try removeItem(atPath: path)
        } catch {
            RoutableLogger.logError("Can not remove item at path", error: error, data: ["path": path], file: file, function: function, line: line)
        }
    }
    
    /// Removes item if it exists and logs error if unable.
    func safeRemoveItemIfExists(at url: URL, file: String = #file, function: String = #function, line: UInt = #line) {
        guard fileExists(atPath: url.path) else { return }
        
        do {
            try removeItem(at: url)
        } catch {
            RoutableLogger.logError("Can not remove item at URL", error: error, data: ["url": url], file: file, function: function, line: line)
        }
    }
    
    /// Returns file size or `nil` and logs error if unable
    func safeFileSize(url: URL, file: String = #file, function: String = #function, line: UInt = #line) -> UInt64? {
        do {
            let attributes = try attributesOfItem(atPath: url.path)
            return attributes[.size] as? UInt64
        } catch {
            RoutableLogger.logError("Can not get file size", error: error, data: ["url": url], file: file, function: function, line: line)
            return nil
        }
    }
    
    /// Returns item modification date or `nil` and logs error if unable
    func safeGetModificationDate(url: URL, file: String = #file, function: String = #function, line: UInt = #line) -> Date? {
        guard let attributes = safeGetAttributes(url: url, file: file, function: function, line: line) else { return nil }
        guard let date = attributes[.modificationDate] as? Date else { return nil }
        return date
    }
    
    /// Returns item attributes or `nil` and logs error if unable
    func safeGetAttributes(url: URL, file: String = #file, function: String = #function, line: UInt = #line) -> [FileAttributeKey: Any]? {
        do {
            let attributes = try attributesOfItem(atPath: url.path)
            return attributes
        } catch {
            RoutableLogger.logError("Can not get modification date", error: error, data: ["url": url], file: file, function: function, line: line)
            return nil
        }
    }
    
    /// Sets item modification date or logs error if unable
    func safeSetModificationDate(_ date: Date, url: URL, file: String = #file, function: String = #function, line: UInt = #line) {
        do {
            try setAttributes([.modificationDate: date], ofItemAtPath: url.path)
        } catch {
            // Happens during high UI load
            RoutableLogger.logError("Can not set modification date", error: error, data: ["url": url], file: file, function: function, line: line)
        }
    }
    
    /// Safely returns directory contents or an empty array if unable.
    func safeGetContents(url: URL, file: String = #file, function: String = #function, line: UInt = #line) -> [URL] {
        guard fileExists(atPath: url.path) else { return [] }
        
        let contents: [URL]
        do {
            contents = try contentsOfDirectory(at: url, includingPropertiesForKeys: [])
        } catch {
            RoutableLogger.logError("Can not get contents of a directory", error: error, data: ["url": url], file: file, function: function, line: line)
            return []
        }
        
        return contents
    }
    
    /// Safely creates directory if it isn't exist or reports error if unable.
    func safeCreateDirectory(at url: URL,
                             withIntermediateDirectories createIntermediates: Bool,
                             attributes: [FileAttributeKey: Any]? = nil,
                             file: String = #file,
                             function: String = #function,
                             line: UInt = #line) {
        
        guard !fileExists(atPath: url.path) else { return }
        
        do {
            try createDirectory(at: url, withIntermediateDirectories: createIntermediates, attributes: attributes)
        } catch {
            RoutableLogger.logError("Can not create directory",
                                    error: error,
                                    data: [
                                        "url": url,
                                        "createIntermediates": createIntermediates,
                                        "attributes": attributes
                                    ],
                                    file: file,
                                    function: function,
                                    line: line)
        }
    }
    
    /// Safely removes item if it exists or reports error if unable.
    func safeRemoveItem(url: URL,
                        file: String = #file,
                        function: String = #function,
                        line: UInt = #line) {
        
        do {
            guard fileExists(atPath: url.path) else { return }
            try removeItem(at: url)
            
        } catch {
            RoutableLogger.logError("Can not delete file",
                                    error: error,
                                    data: ["url": url],
                                    file: file,
                                    function: function,
                                    line: line)
        }
    }
}
