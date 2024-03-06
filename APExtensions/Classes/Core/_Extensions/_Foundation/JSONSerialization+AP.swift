//
//  JSONSerialization+AP.swift
//  Pods
//
//  Created by Anton Plebanovich on 6.03.24.
//  Copyright © 2024 Anton Plebanovich. All rights reserved.
//

import Foundation
import RoutableLogger

public extension JSONSerialization {
    
    static func safeJSONData(object: Any, options: JSONSerialization.WritingOptions, file: String = #file, function: String = #function, line: UInt = #line) -> Data? {
        
        guard isValidJSONObject(self) else {
            RoutableLogger.logError("Ivalid JSON object", data: ["self": self, "options": options], file: file, function: function, line: line)
            return nil
        }
        
        do {
            return try data(withJSONObject: self, options: options)
        } catch {
            RoutableLogger.logError("Unable to transform object to JSON string", error: error, data: ["self": self, "options": options], file: file, function: function, line: line)
            return nil
        }
    }
}
