//
//  Collection+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/21/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension Collection {
    /// Checks if collection has elements
    var hasElements: Bool {
        return !isEmpty
    }
}

// ******************************* MARK: - Scripting

public extension Collection {
    @inlinable func count(where isIncluded: (Element) throws -> Bool) rethrows -> Int {
        try filter(isIncluded).count
    }
    
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
    
    /// Helper method to filter out duplicates. Element will be filtered out if closure return true.
    @inlinable func filterDuplicates(_ includeElement: (_ lhs: Element, _ rhs: Element) throws -> Bool) rethrows -> [Element] {
        var results = [Element]()
        
        try forEach { element in
            let existingElements = try results.filter {
                return try includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }
    
    /// Transforms an array to a dictionary using array elements as keys and transform result as values.
    @inlinable func dictionaryMap<T>(_ transform: (_ element: Iterator.Element) throws -> T?) rethrows -> [Iterator.Element: T] {
        return try self.reduce(into: [Iterator.Element: T]()) { dictionary, element in
            guard let value = try transform(element) else { return }
            
            dictionary[element] = value
        }
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

// ******************************* MARK: - Equatable

public extension Collection where Element: Equatable {
    
    /// Returns whether collection has at least one common element with passed array.
    @inlinable func hasIntersection(with array: [Element]) -> Bool {
        return contains { array.contains($0) }
    }
    
    /// Returns intersection array.
    @inlinable func intersection(with array: [Element]) -> [Element] {
        return filter { array.contains($0) }
    }
    
    /// Helper method to filter out duplicates
    @inlinable func filterDuplicates() -> [Element] {
        return filterDuplicates { $0 == $1 }
    }
}

// ******************************* MARK: - As

public extension Collection {
    
    /// Returns `self` as `Array`.
    var asArray: [Element] {
        return Array(self)
    }
}
