//
//  JSONSerializable.swift
//  Pods
//
//  Created by Anton Plebanovich on 9.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import RoutableLogger

public protocol JSONSerializable {}

public extension JSONSerializable {
    
    /// Returns `self` converted to a JSON string or reports an error an returns `nil` if unable.
    /// It's using keys sorting on iOS 11 or higher.
    var asJSONString: String? {
        if #available(iOS 11.0, *) {
            return toJSONString(options: [.sortedKeys])
        } else {
            return toJSONString(options: [])
        }
    }
    
    var asPrettyJSONString: String? {
        if #available(iOS 11.0, *) {
            return toJSONString(options: [.sortedKeys, .prettyPrinted])
        } else {
            return toJSONString(options: [.prettyPrinted])
        }
    }
    
    func toJSONString(options: JSONSerialization.WritingOptions, file: String = #file, function: String = #function, line: UInt = #line) -> String? {
        do {
            let objectData: Data = try JSONSerialization.data(withJSONObject: self, options: options)
            let objectString: String = objectData.utf8String ?? ""
            return objectString
            
        } catch {
            RoutableLogger.logError("Unable to transform array to JSON string", error: error, data: ["self": self, "options": options], file: file, function: function, line: line)
            return nil
        }
    }
}

extension Array: JSONSerializable {}
extension Dictionary: JSONSerializable {}
