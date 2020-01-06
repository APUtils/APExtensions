//
//  Collection+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/21/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Scripting

extension Collection {
    
    /// Helper method to enumerate all objects in array together with index
    @inlinable func enumerateForEach(_ body: (_ index: Index, _ element: Element) throws -> ()) rethrows {
        for index in indices {
            try body(index, self[index])
        }
    }
    
    /// Helper method to map all objects in array together with index
    @inlinable func enumerateMap<T>(_ body: (_ index: Index, _ element: Element) throws -> T) rethrows -> [T] {
        var map: [T] = []
        for index in indices {
            map.append(try body(index, self[index]))
        }
        
        return map
    }
    
    /// Groups array elements into dictionary using provided transform to determine element's key.
    @inlinable func group<K>(_ keyTransform: (Iterator.Element) throws -> K) rethrows -> [K: [Iterator.Element]] {
        var dictionary = [K: [Iterator.Element]]()
        for index in indices {
            let element = self[index]
            let key = try keyTransform(element)
            var array = dictionary[key] ?? []
            array.append(element)
            dictionary[key] = array
        }
        
        return dictionary
    }
}

// ******************************* MARK: - Splitting

public extension Collection where Index == Int {
    /// Splits array into slices of specified size
    func splittedArray(splitSize: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: splitSize).map {
            Array(self[$0..<Swift.min($0 + splitSize, count)])
        }
    }
}
