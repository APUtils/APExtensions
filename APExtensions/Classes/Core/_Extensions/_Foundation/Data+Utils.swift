//
//  Data+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/12/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension Data {
    
    // ******************************* MARK: - Hex
    
    /// Get HEX string from data. Can be used for sending APNS token to backend.
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
    
    /// Creates data from HEX string
    init(hex: String) {
        var hex = hex.replacingOccurrences(of: " ", with: "")
        var data = Data()
        while hex.count > 0 {
            let subIndex = hex.index(hex.startIndex, offsetBy: 2)
            let c = String(hex[..<subIndex])
            hex = String(hex[subIndex...])
            var ch: UInt32 = 0
            Scanner(string: c).scanHexInt32(&ch)
            var char = UInt8(ch)
            data.append(&char, count: 1)
        }
        
        self = data
    }
    
    // ******************************* MARK: - String
    
    /// Try to convert data to UTF8 string
    var utf8String: String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
    
    /// String representation for data.
    /// Try to decode as UTF8 string first.
    /// Uses hex representation if data can not be represented as UTF8 string.
    var asString: String {
        return utf8String ?? hexString
    }
    
    // ******************************* MARK: - Other
    
    /// Try to serialize JSON data
    var jsonObject: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [])
    }
    
    /// Try to get dictionary from JSON data
    var jsonDictionary: [String : Any]? {
        return jsonObject as? [String : Any]
    }
    
    /// Try to get array from JSON data
    var jsonArray: [Any]? {
        return jsonObject as? [Any]
    }
    
    /// Try to get string for key in dictionary from JSON data
    func jsonDictionaryStringForKey(_ key: String) -> String? {
        guard let dictionary = jsonDictionary else { return nil }
        
        let value = dictionary[key]
        
        return value as? String
    }
}
