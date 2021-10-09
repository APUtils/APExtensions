//
//  Codable+Utils.swift
//  Pods
//
//  Created by Anton Plebanovich on 9.10.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Property List Codable

public extension Encodable {
    
    /// Encodes the object into a property list.
    func propertyListEncoded() throws -> Data {
        let encoder = PropertyListEncoder()
        return try encoder.encode(self)
    }
}

public extension Decodable {
    
    /// Creates object from property list data.
    static func create(propertyListData: Data) throws -> Self {
        let decoder = PropertyListDecoder()
        return try decoder.decode(Self.self, from: propertyListData)
    }
}

// ******************************* MARK: - JSON Codable

public extension Encodable {
    
    /// Encodes the object into a property list and throws an error if unable.
    func jsonEncoded() throws -> Data {
        let encoder = JSONEncoder()
        if #available(iOS 11.0, *) {
            encoder.outputFormatting = .sortedKeys
        }
        
        return try encoder.encode(self)
    }
}

public extension Decodable {
    
    /// Creates object from JSON data and throws error if unable.
    static func create(jsonData: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: jsonData)
    }
}
