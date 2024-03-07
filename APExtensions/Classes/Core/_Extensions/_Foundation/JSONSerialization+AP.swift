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
        
        guard isValidJSONObject(object) else {
            RoutableLogger.logError("Ivalid JSON object", data: ["object": object, "options": options], file: file, function: function, line: line)
            return nil
        }
        
        do {
            return try data(withJSONObject: object, options: options)
        } catch {
            RoutableLogger.logError("Unable to transform object to JSON string", error: error, data: ["object": object, "options": options], file: file, function: function, line: line)
            return nil
        }
    }
}
