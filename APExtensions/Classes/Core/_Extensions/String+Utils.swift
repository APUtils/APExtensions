//
//  String+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 16/04/16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


// ******************************* MARK: - Representation

public extension String {
    /// Returns string as URL
    @available(*, deprecated, renamed: "asURL")
    var asUrl: URL? {
        return asURL
    }
    
    /// Returns string as URL. Properly escapes URL components if needed.
    var asURL: URL? {
        // Check for existing percent escapes first to prevent double-escaping of % character
        if range(of: "%[0-9A-Fa-f]{2}", options: .regularExpression, range: nil, locale: nil) != nil {
            // Already encoded
            return URL(string: self)
        }
        
        // Gettin host component
        var reducedString = self
        var components = reducedString.components(separatedBy: "://")
        let hostComponent: String
        if components.count == 2 {
            hostComponent = components[0]
            reducedString = components[1]
        } else {
            hostComponent = ""
        }
        
        // Getting fragment component
        components = reducedString.components(separatedBy: "#")
        let fragmentComponent: String
        if components.count == 2 {
            reducedString = components[0]
            fragmentComponent = components[1]
        } else {
            reducedString = components[0]
            fragmentComponent = ""
        }
        
        // Getting query component
        components = reducedString.components(separatedBy: "?")
        let queryComponent: String
        if components.count == 2 {
            reducedString = components[0]
            queryComponent = components[1]
        } else {
            reducedString = components[0]
            queryComponent = ""
        }
        
        // What have left is a path
        let pathComponent: String = reducedString
        
        guard let escapedHostComponent = hostComponent.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        guard let escapedPathComponent = pathComponent.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else { return nil }
        guard let escapedQueryComponent = queryComponent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        guard let escapedFragmentComponent = fragmentComponent.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return nil }
        
        var urlString = ""
        
        if !escapedHostComponent.isEmpty {
            urlString = "\(escapedHostComponent)://"
        }
        
        if !escapedPathComponent.isEmpty {
            urlString = "\(urlString)\(escapedPathComponent)"
        }
        
        if !escapedQueryComponent.isEmpty {
            urlString = "\(urlString)?\(escapedQueryComponent)"
        }
        
        if !escapedFragmentComponent.isEmpty {
            urlString = "\(urlString)#\(escapedFragmentComponent)"
        }
        
        return URL(string: urlString)
    }
    
    /// Returns string as Int
    var asInt: Int? {
        return Int(self)
    }
    
    /// Returns string as NSAttributedString
    var asAttributedString: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    /// Returns string as NSMutableAttributedString
    var asMutableAttributedString: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}

// ******************************* MARK: - Subscript

public extension String {
    subscript(i: Int) -> Character {
        let index: Index = self.index(self.startIndex, offsetBy: i)
        return self[index]
    }
    
    subscript(i: Int) -> String {
        let character: Character = self[i]
        return String(character)
    }
    
    subscript(range: Range<Int>) -> String {
        let start: Index = index(startIndex, offsetBy: range.lowerBound)
        let end: Index = index(start, offsetBy: range.upperBound - range.lowerBound)
        let range = start ..< end
        return String(self[range])
    }
    
    var first: String {
        return isEmpty ? "" : self[0]
    }
}

// ******************************* MARK: - Base64

public extension String {
    /// Returns base64 encoded string
    var encodedBase64: String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    /// Returns string decoded from base64 string
    var decodedBase64: String? {
        var encodedString = self
        
        // String MUST be dividable by 4. https://stackoverflow.com/questions/36364324/swift-base64-decoding-returns-nil/36366421#36366421
        let remainder = encodedString.count % 4
        if remainder > 0 {
            encodedString = encodedString.padding(toLength: encodedString.count + 4 - remainder, withPad: "=", startingAt: 0)
        }
        
        guard let data = Data(base64Encoded: encodedString) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
}

// ******************************* MARK: - Get random symbol from string

public extension String {
    /// Returns random symbol from string
    func randomSymbol() -> String {
        let count: UInt32 = UInt32(self.count)
        let random: Int = Int(arc4random_uniform(count))
        return self[random]
    }
}

// ******************************* MARK: - Trimming

public extension String {
    /// Strips whitespace and new line characters
    var trimmed: String {
        let trimmedString = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
}

// ******************************* MARK: - Appending

public extension String {
    mutating func appendNewLine() {
        append("\n")
    }
    
    mutating func append(valueName: String?, value: Any?, separator: String = ", ") {
        var stringRepresentation: String
        if let value = g.unwrap(value) {
            if let value = value as? String {
                stringRepresentation = value
            } else if let bool = value as? Bool {
                stringRepresentation = bool ? "true" : "false"
            } else {
                stringRepresentation = String(describing: value)
            }
        } else {
            stringRepresentation = "nil"
        }
        
        if let valueName = valueName {
            append(string: "\(valueName):", separator: separator)
            appendWithSpace(stringRepresentation)
        } else {
            append(string: stringRepresentation, separator: separator)
        }
    }
    
    mutating func appendWithNewLine(_ string: String?) {
        append(string: string, separator: "\n")
    }
    
    mutating func appendWithSpace(_ string: String?) {
        append(string: string, separator: " ")
    }
    
    mutating func appendWithComma(_ string: String?) {
        append(string: string, separator: ", ")
    }
    
    mutating func append(string: String?, separator: String) {
        guard let string = string, !string.isEmpty else { return }
        
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

// ******************************* MARK: - Splitting

public extension String {
    /// Splits string by capital letters without stripping them
    var splittedByCapitals: [String] {
        return splitBefore(separator: { $0.isUpperCase }).map({ String($0) })
    }
    
    /// Split string into slices of specified length
    func splitByLength(_ length: Int) -> [String] {
        var result = [String]()
        var collectedCharacters = [Character]()
        collectedCharacters.reserveCapacity(length)
        var count = 0
        
        for character in self {
            collectedCharacters.append(character)
            count += 1
            if (count == length) {
                // Reached the desired length
                count = 0
                result.append(String(collectedCharacters))
                collectedCharacters.removeAll(keepingCapacity: true)
            }
        }
        
        // Append the remainder
        if !collectedCharacters.isEmpty {
            result.append(String(collectedCharacters))
        }
        
        return result
    }
}

// ******************************* MARK: - Bounding Rect

public extension String {
    /// Width of a string written in one line.
    func oneLineWidth(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return boundingBox.width
    }
    
    /// Height of a string for specified font and width.
    func height(font: UIFont, width: CGFloat) -> CGFloat {
        return height(attributes: [.font: font], width: width)
    }
    
    /// Height of a string for specified attributes and width.
    func height(attributes: [NSAttributedString.Key: Any], width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let height = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).height + c.pixelSize
        
        return height
    }
}
