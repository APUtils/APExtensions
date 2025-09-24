//
//  String+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 16/04/16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation
import RoutableLogger

// ******************************* MARK: - Appending

public extension String {
    mutating func appendNewLine() {
        append("\n")
    }
    
    mutating func append(valueName: String?, value: Any?, separator: String = ", ", skipEmpty: Bool = true) {
        var stringRepresentation: String
        if let value = g.unwrap(value) {
            if let value = value as? String {
                stringRepresentation = value
            } else if let bool = value as? Bool {
                stringRepresentation = bool ? "true" : "false"
            } else {
                stringRepresentation = "\(value)"
            }
        } else {
            stringRepresentation = "nil"
        }
        
        if let valueName = valueName {
            append("\(valueName):", separator: separator, skipEmpty: skipEmpty)
            appendWithSpace(stringRepresentation)
        } else {
            append(stringRepresentation, separator: separator, skipEmpty: skipEmpty)
        }
    }
    
    mutating func appendWithNewLine(_ string: String?, skipEmpty: Bool = true) {
        append(string, separator: "\n", skipEmpty: skipEmpty)
    }
    
    mutating func appendWithSpace(_ string: String?, skipEmpty: Bool = true) {
        append(string, separator: " ", skipEmpty: skipEmpty)
    }
    
    mutating func appendWithBar(_ string: String?, skipEmpty: Bool = true) {
        append(string, separator: " | ", skipEmpty: skipEmpty)
    }
    
    mutating func appendWithComma(_ string: String?, skipEmpty: Bool = true) {
        append(string, separator: ", ", skipEmpty: skipEmpty)
    }

    mutating func appendWithSemicolon(_ string: String?, skipEmpty: Bool = true) {
        append(string, separator: "; ", skipEmpty: skipEmpty)
    }
    
    mutating func append(_ string: String?, separator: String, skipEmpty: Bool = true) {
        guard let string = string, !skipEmpty || !string.isEmpty else { return }
        
        if isEmpty {
            self.append(string)
        } else {
            self.append("\(separator)\(string)")
        }
    }
    
    mutating func wrap(`class`: Any.Type) {
        self = String(format: "%@(%@)", String(describing: `class`), self)
    }
}
// ******************************* MARK: - Capitalization

public extension String {
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

// ******************************* MARK: - Random

public extension String {
    
    /// Generates random string with spaces.
    static func random(length: Int, averageWordLength: Int? = nil) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let spacesCount = averageWordLength == nil ? 0 : letters.count / averageWordLength!
        let lettersWithSpace = letters.appending(String(repeating: " ", count: spacesCount))
        return String((0..<length).map{ _ in lettersWithSpace.randomElement()! })
    }
}

// ******************************* MARK: - Safe

public extension String {
    
    /// Safely initializes string with contents of a file or returns `nil` and reports an error if unable.
    init?(safeContentsOf url: URL, encoding: Encoding, file: String = #file, function: String = #function, line: UInt = #line) {
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            RoutableLogger.logError("Unable to get contents of non-existing file", data: ["url": url], file: file, function: function, line: line)
            return nil
        }
        
        do {
            try self.init(contentsOf: url, encoding: encoding)
        } catch {
            RoutableLogger.logError("Can not get contents of a file", error: error, data: ["url": url], file: file, function: function, line: line)
            return nil
        }
    }
}

// ******************************* MARK: - Other

public extension String {
    
    /// Returns fileName without extension
    var fileName: String {
        guard let lastPathComponent = components(separatedBy: "/").last else { return "" }
        
        var components = lastPathComponent.components(separatedBy: ".")
        if components.count == 1 {
            return lastPathComponent
        } else {
            components.removeLast()
            return components.joined(separator: ".")
        }
    }
}
