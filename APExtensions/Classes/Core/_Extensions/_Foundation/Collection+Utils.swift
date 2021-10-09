//
//  Collection+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/21/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Scripting

public extension Collection {
    
    /// Helper method to enumerate all objects in array together with index
    @inlinable func enumerateForEach(_ body: (_ index: Index, _ element: Element) throws -> ()) rethrows {
        for index in indices {
            try body(index, self[index])
        }
    }
    
    /// Helper method to map all objects in a connection together with index
    @inlinable func enumerateMap<T>(_ body: (_ index: Index, _ element: Element) throws -> T) rethrows -> [T] {
        var map: [T] = []
        for index in indices {
            map.append(try body(index, self[index]))
        }
        
        return map
    }
    
    /// Helper method to map all objects in a collection together with previous element.
    @inlinable
    func mapWithPrevious<T>(_ transform: (Self.Element, Self.Element) throws -> T) rethrows -> [T] {
        var array: [T] = []
        
        var previous: Self.Element?
        try forEach { element in
            defer { previous = element }
            guard let previous = previous else { return }
            
            let newElement = try transform(previous, element)
            array.append(newElement)
        }
        
        return array
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
    
    /// Returns element from the collection or `nil` if index is out of bounds.
    subscript(optional i: Index) -> Iterator.Element? {
        indices.contains(i) ? self[i] : nil
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
