//
//  Data+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/12/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation
import RoutableLogger

public extension Data {
    
    // ******************************* MARK: - Safe
    
    /// String representation for data.
    /// Try to decode as UTF8 string at first.
    /// Try to decode as ASCII string at second.
    /// Uses hex representation if data can not be represented as UTF8 or ASCII string.
    func safeString(file: String = #file, function: String = #function, line: UInt = #line) -> String {
        safeUTF8String(file: file, function: function, line: line)
        ?? safeASCIIString(file: file, function: function, line: line)
        ?? toHEXString()
    }
    
    /// Try to convert data to ASCII string
    func safeASCIIString(file: String = #file, function: String = #function, line: UInt = #line) -> String? {
        guard let string = String(data: self, encoding: String.Encoding.ascii) else {
            RoutableLogger.logError("Unable to create ASCII string from data", data: ["data": self], file: file, function: function, line: line)
            return nil
        }
        
        return string
    }
    
    /// Try to convert data to UTF8 string
    func safeUTF8String(file: String = #file, function: String = #function, line: UInt = #line) -> String? {
        guard let string = String(data: self, encoding: String.Encoding.utf8) else {
            RoutableLogger.logError("Unable to create UTF8 string from data", data: ["data": self], file: file, function: function, line: line)
            return nil
        }
        
        return string
    }
    
    // ******************************* MARK: - Hex
    
    /// Get HEX string from data. Can be used for sending APNS token to backend.
    func toHEXString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
    
    /// Creates data from HEX string
    @available(iOS, introduced: 2.0, deprecated: 13.0)
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
    
    // ******************************* MARK: - Other
    
    // TODO: Rework all
    
    /// Try to get dictionary from JSON data
    func safeJSONDictionary(file: String = #file, function: String = #function, line: UInt = #line) -> [String: Any]? {
        do {
            let jsonObject: Any
            if #available(iOS 15.0, *) {
                jsonObject = try JSONSerialization.jsonObject(with: self, options: [.json5Allowed, .topLevelDictionaryAssumed])
            } else {
                jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            }
            guard let dictionary = jsonObject as? [String: Any] else {
                RoutableLogger.logError("Unable to convert object to dictionary", data: ["data": self, "jsonObject": jsonObject, "type": type(of: jsonObject)], file: file, function: function, line: line)
                return nil
            }
            
            return dictionary
            
        } catch {
            RoutableLogger.logError("Unable to serialize data to dictionary", error: error, data: ["data": self], file: file, function: function, line: line)
            return nil
        }
    }
    
    /// Try to get array from JSON data
    func safeJSONArray(file: String = #file, function: String = #function, line: UInt = #line) -> [Any]? {
        do {
            let jsonObject: Any
            if #available(iOS 15.0, *) {
                jsonObject = try JSONSerialization.jsonObject(with: self, options: [.json5Allowed])
            } else {
                jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            }
            guard let array = jsonObject as? [Any] else {
                RoutableLogger.logError("Unable to convert object to array", data: ["data": self, "jsonObject": jsonObject, "type": type(of: jsonObject)], file: file, function: function, line: line)
                return nil
            }
            
            return array
            
        } catch {
            RoutableLogger.logError("Unable to serialize data to array", error: error, data: ["data": self], file: file, function: function, line: line)
            return nil
        }
    }
    
    /// Try to serialize JSON data
    var jsonObject: Any? {
        if #available(iOS 15.0, *) {
            return try? JSONSerialization.jsonObject(with: self, options: [.json5Allowed])
        } else {
            return try? JSONSerialization.jsonObject(with: self, options: [.fragmentsAllowed])
        }
    }
    
    /// Try to get string for key in dictionary from JSON data
    func jsonDictionaryStringForKey(_ key: String) -> String? {
        guard let dictionary = safeJSONDictionary() else { return nil }
        
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
            RoutableLogger.logError("Can not get data from url", error: error, data: ["url": url], file: file, function: function, line: line)
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
            RoutableLogger.logError("Unable to write data", error: error, data: ["self": safeString(), "url": url], file: file, function: function, line: line)
            return false
        }
    }
    
    /// Try to serialize `self` to JSON object and report error if unable.
    func safeSerializeToJSON() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            RoutableLogger.logError("Unable to parse data to JSON", error: error, data: ["self": safeString()])
            return nil
        }
    }
}

// ******************************* MARK: - Compression

@available(iOS 13.0, *)
public extension Data {
    
    /// - note: In rare cases for some reason compression may fail
    func safeCompressed(using algorithm: NSData.CompressionAlgorithm) -> Data? {
        do {
            return try (self as NSData).compressed(using: algorithm) as Data
        } catch {
            RoutableLogger.logError("Unable to compress data", data: ["data": safeString()])
            return nil
        }
    }
    
    func safeDecompressed(using algorithm: NSData.CompressionAlgorithm) -> Data? {
        do {
            return try (self as NSData).decompressed(using: algorithm) as Data
        } catch {
            RoutableLogger.logError("Unable to decompress data", data: ["data": safeString()])
            return nil
        }
    }
}
