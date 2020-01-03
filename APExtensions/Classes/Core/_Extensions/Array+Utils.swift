//
//  Array+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 09.08.16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension Array {
    /// Second element in array
    var second: Element? {
        guard count > 1 else { return nil }
        
        return self[1]
    }
    
    /// Replaces last element with new element and returns replaced element.
    @discardableResult
    mutating func replaceLast(_ element: Element) -> Element {
        let lastElement = removeLast()
        append(element)
        
        return lastElement
    }
}

// ******************************* MARK: - Scripting

public extension Array {
    
    /// Helper method to modify all value type objects in array
    @inlinable mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) throws -> ()) rethrows {
        for index in indices {
            try modifyElement(atIndex: index) { try body(index, &$0) }
        }
    }
    
    /// Helper method to modify value type objects in array at specific index
    @inlinable mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) throws -> ()) rethrows {
        var element = self[index]
        try modifyElement(&element)
        self[index] = element
    }
    
    /// Helper methods to remove object using closure
    @discardableResult @inlinable mutating func remove(_ body: (_ element: Element) throws -> Bool) rethrows -> Element? {
        guard let index = try firstIndex(where: body) else { return nil }
        
        return remove(at: index)
    }
    
    @inlinable mutating func move(from: Index, to: Index) {
        let element = remove(at: from)
        insert(element, at: to)
    }
}

// ******************************* MARK: - Equatable

public extension Array where Element: Equatable {
    
    /// Helper method to remove all objects that are equal to passed one.
    @inlinable mutating func removeAll(_ element: Element) {
        removeAll { $0 == element }
    }
    
    /// Returns array removing all objects that are equal to passed one.
    @inlinable func removingAll(_ element: Element) -> [Element] {
        var resultArray = self
        resultArray.removeAll(element)
        return resultArray
    }
    
    /// Helper method to remove all objects that are equal to those contained in `contentsOf` array.
    @inlinable mutating func removeAll(contentsOf array: [Element]) {
        removeAll { array.contains($0) }
    }
    
    /// Removes the last object that is equal to a passed one.
    @inlinable mutating func removeLast(_ element: Element) {
        guard let lastIndex = lastIndex(of: element) else { return }
        remove(at: lastIndex)
    }
    
    /// Returns array removing the last object that is equal to a passed one.
    @inlinable func removingLast(_ element: Element) -> [Element] {
        var resultArray = self
        resultArray.removeLast(element)
        return resultArray
    }
    
    /// Returns array removing all objects that are equal to those contained in `array`.
    @inlinable func removingAll(contentsOf array: [Element]) -> [Element] {
        var resultArray = self
        resultArray.removeAll(contentsOf: array)
        return resultArray
    }
    
    /// Helper method to append missing elements from passed `array`.
    @inlinable mutating func appendMissing(contentsOf array: [Element]) {
        let missing = array.filter { !contains($0) }
        append(contentsOf: missing)
    }
    
    /// Returns array appending missing elements from passed `array`.
    @inlinable func appendingMissing(contentsOf array: [Element]) -> [Element] {
        let missing = array.filter { !contains($0) }
        var resultArray = self
        resultArray.append(contentsOf: missing)
        return resultArray
    }
}

// ******************************* MARK: - Splitting

public extension Array {
    /// Splits array into slices of specified size
    func splittedArray(splitSize: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: splitSize).map {
            Array(self[$0..<Swift.min($0 + splitSize, count)])
        }
    }
}
