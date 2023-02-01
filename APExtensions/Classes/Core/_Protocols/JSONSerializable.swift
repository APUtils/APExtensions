//
//  JSONSerializable.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation
import RoutableLogger

public protocol JSONSerializable {}

public extension JSONSerializable {
    
    /// Returns `self` converted to a JSON string or reports an error and returns `nil` if unable.
    /// It's using keys sorting on iOS 11 or higher.
    func safeJSONString(file: String = #file, function: String = #function, line: UInt = #line) -> String? {
        if #available(iOS 11.0, *) {
            return safeJSONString(options: [.sortedKeys], file: file, function: function, line: line)
        } else {
            return safeJSONString(options: [], file: file, function: function, line: line)
        }
    }
    
    func safePrettyJSONString(file: String = #file, function: String = #function, line: UInt = #line) -> String? {
        if #available(iOS 11.0, *) {
            return safeJSONString(options: [.sortedKeys, .prettyPrinted], file: file, function: function, line: line)
        } else {
            return safeJSONString(options: [.prettyPrinted], file: file, function: function, line: line)
        }
    }
    
    func safeJSONString(options: JSONSerialization.WritingOptions, file: String = #file, function: String = #function, line: UInt = #line) -> String? {
        safeJSONData(options: options, file: file, function: function, line: line)?
            .safeUTF8String(file: file, function: function, line: line)
    }
    
    func safeJSONData(options: JSONSerialization.WritingOptions, file: String = #file, function: String = #function, line: UInt = #line) -> Data? {
        
        guard JSONSerialization.isValidJSONObject(self) else {
            RoutableLogger.logError("Ivalid JSON object", data: ["self": self, "options": options], file: file, function: function, line: line)
            return nil
        }
        
        do {
            return try JSONSerialization.data(withJSONObject: self, options: options)
        } catch {
            RoutableLogger.logError("Unable to transform object to JSON string", error: error, data: ["self": self, "options": options], file: file, function: function, line: line)
            return nil
        }
    }
}

extension Array: JSONSerializable {}
extension Dictionary: JSONSerializable {}
