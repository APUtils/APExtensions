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
    
    /// Try to convert data to ASCII string
    var asciiString: String? {
        String(data: self, encoding: String.Encoding.ascii)
    }
    
    /// Try to convert data to UTF8 string
    var utf8String: String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
    
    /// String representation for data.
    /// Try to decode as UTF8 string at first.
    /// Try to decode as ASCII string at second.
    /// Uses hex representation if data can not be represented as UTF8 or ASCII string.
    var asString: String {
        utf8String ?? asciiString ?? hexString
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

// ******************************* MARK: - Safe Methods

public extension Data {
    
    /// Initialize data with content of a given file and report error if unable.
    init?(safeContentsOf url: URL, file: String = #file, function: String = #function, line: UInt = #line) {
        do {
            try self.init(contentsOf: url)
        } catch {
            logError("Can not get data from url", error: error, data: ["url": url], file: file, function: function, line: line)
            return nil
        }
    }
    
    /// Write the contents of the `Data` to a location and report error if unable.
    ///
    /// - parameter url: The location to write the data into.
    /// - parameter options: Options for writing the data. Default value is `[]`.
    /// - throws: An error in the Cocoa domain, if there is an error writing to the `URL`.
    @discardableResult
    func safeWrite(to url: URL, options: Data.WritingOptions = [], file: String = #file, function: String = #function, line: UInt = #line) -> Bool {
        do {
            try write(to: url, options: options)
            return true
        } catch {
            logError("Unable to write data", error: error, file: file, function: function, line: line)
            return false
        }
    }
}
