//
//  Sequence+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/4/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


// ******************************* MARK: - As

public extension Sequence {
    
    /// Returns `self` as `Array`.
    var asArray: [Element] {
        if let array = self as? [Element] {
            return array
        } else {
            return Array(self)
        }
    }
}

// ******************************* MARK: - Splitting

public extension Sequence {
    func splitBefore(separator isSeparator: (Iterator.Element) -> Bool) -> [AnySequence<Iterator.Element>] {
        var result: [AnySequence<Iterator.Element>] = []
        var subSequence: [Iterator.Element] = []
        
        var iterator = makeIterator()
        while let element = iterator.next() {
            if isSeparator(element) {
                if !subSequence.isEmpty {
                    result.append(AnySequence(subSequence))
                }
                subSequence = [element]
            } else {
                subSequence.append(element)
            }
        }
        result.append(AnySequence(subSequence))
        
        return result
    }
}

// ******************************* MARK: - Equatable

public extension Sequence where Element: Equatable {
    
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

// ******************************* MARK: - Hashable

public extension Sequence where Element: Hashable {
    
    /// Fast method to get unique values without keeping an order.
    /// - note: It's ~1000 times faster than `filterDuplicates()` for 10000 items sequence.
    @inlinable func uniqueUnordered() -> [Element] {
        return Array(Set(self))
    }
}

// ******************************* MARK: - Scripting

public extension Sequence {
    @inlinable func count(where isIncluded: (Element) throws -> Bool) rethrows -> Int {
        try filter(isIncluded).count
    }
    
    /// Helper method to filter out duplicates. Element will be filtered out if closure return true.
    @inlinable func filterDuplicates(_ isDuplicate: (_ lhs: Element, _ rhs: Element) throws -> Bool) rethrows -> [Element] {
        var results = [Element]()
        
        try forEach { element in
            let duplicate = try results.contains {
                return try isDuplicate(element, $0)
            }
            if !duplicate {
                results.append(element)
            }
        }
        
        return results
    }
    
    /// Transforms an array to a dictionary using array elements as keys and transform result as values.
    @inlinable func dictionaryMapKeys<T>(_ transform: (_ element: Iterator.Element) throws -> T?) rethrows -> [Iterator.Element: T] {
        return try self.reduce(into: [Iterator.Element: T]()) { dictionary, element in
            guard let value = try transform(element) else { return }
            dictionary[element] = value
        }
    }
    
    /// Transforms an array to a dictionary using array elements as values and transform result as keys.
    @inlinable func dictionaryMapValues<T>(_ transform: (_ element: Iterator.Element) throws -> T?) rethrows -> [T: Iterator.Element] {
        return try self.reduce(into: [T: Iterator.Element]()) { dictionary, element in
            guard let key = try transform(element) else { return }
            dictionary[key] = element
        }
    }
}

// ******************************* MARK: - Operations

public extension Sequence where Element: BinaryFloatingPoint {
    
    /// Returns averge value of all elements in a sequence.
    func average() -> Element {
        var i: Element = 0
        var total: Element = 0
        
        for value in self {
            total = total + value
            i += 1
        }
        
        if i == 0 {
            return 0
        } else {
            return total / i
        }
    }
}
