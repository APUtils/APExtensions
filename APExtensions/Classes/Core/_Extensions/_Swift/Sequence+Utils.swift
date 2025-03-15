//
//  Sequence+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/4/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

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

// ******************************* MARK: - To

public extension Sequence where Element: Hashable {
    
    /// Transforms `self` to `Set`.
    func toSet() -> Set<Element> {
        Set(self)
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
}

// ******************************* MARK: - Hashable

public extension Sequence where Element: Hashable {
    
    /// Fast method to get unique values without keeping an order.
    /// - note: It's ~1000 times faster than `filterDuplicates()` for 10000 items sequence.
    @inlinable func uniqueUnordered() -> [Element] {
        return Array(Set(self))
    }
}

public extension Sequence {
    
    /// Fast method to get unique values without keeping an order.
    @inlinable func uniqueUnorderedCompactMap<T: Hashable>(_ compactMap: (Element) throws -> T?) rethrows -> [T] {
        var set = Set<T>()
        try forEach {
            if let element = try compactMap($0) {
                set.insert(element)
            }
        }
        
        return Array(set)
    }
    
    /// Fast method to get unique values without keeping an order.
    @inlinable func uniqueOrderedCompactMap<T: Hashable>(_ compactMap: (Element) throws -> T?) rethrows -> [T] {
        var array = Array<T>()
        var set = Set<T>()
        try forEach {
            if let element = try compactMap($0), !set.contains(element) {
                set.insert(element)
                array.append(element)
            }
        }
        
        return array
    }
}

// ******************************* MARK: - Scripting

public extension Sequence {
    @inlinable func count(where isIncluded: (Element) throws -> Bool) rethrows -> Int {
        try filter(isIncluded).count
    }
    
    /// Transforms an array to a dictionary using array elements as values and transform result as keys.
    @inlinable func dictionaryMapKeys<T>(_ transform: (_ element: Iterator.Element) throws -> T?) rethrows -> [T: Iterator.Element] {
        return try self.reduce(into: [T: Iterator.Element]()) { dictionary, element in
            guard let key = try transform(element) else { return }
            dictionary[key] = element
        }
    }
    
    /// Transforms an array to a dictionary using array elements as keys and transform result as values.
    @inlinable func dictionaryMapValues<T>(_ transform: (_ element: Iterator.Element) throws -> T?) rethrows -> [Iterator.Element: T] {
        return try self.reduce(into: [Iterator.Element: T]()) { dictionary, element in
            guard let value = try transform(element) else { return }
            dictionary[element] = value
        }
    }
    
    /// Transforms an array to a dictionary using key and value transforms.
    @inlinable func dictionaryMapKeysAndValues<K, V>(keyTransform: (_ element: Iterator.Element) throws -> K?, valueTransform: (_ element: Iterator.Element) throws -> V?) rethrows -> [K: V] {
        return try reduce(into: [K: V]()) { dictionary, element in
            guard let key = try keyTransform(element) else { return }
            guard let value = try valueTransform(element) else { return }
            dictionary[key] = value
        }
    }
}

// ******************************* MARK: - Operations

public extension Sequence where Element: BinaryFloatingPoint {
    
    /// Returns averge value of all elements in a sequence.
    func average() -> Element? {
        var i: Element = 0
        var total: Element = 0
        
        for value in self {
            total = total + value
            i += 1
        }
        
        if i == 0 {
            return nil
        } else {
            return total / i
        }
    }
}

public extension Sequence where Element: Sequence {
    
    /// Flattens array of arrays
    func flatten() -> [Element.Element] {
        flatMap { $0 }
    }
}
