//
//  Array+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 09.08.16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension Array {
    /// Second element in array
    public var second: Element? {
        guard count > 1 else { return nil }
        
        return self[1]
    }
}

//-----------------------------------------------------------------------------
// MARK: - Scripting
//-----------------------------------------------------------------------------

public extension Array {
    /// Helper method to modify all value type objects in array
    public mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) throws -> ()) rethrows {
        for index in indices {
            try modifyElement(atIndex: index) { try body(index, &$0) }
        }
    }
    
    /// Helper method to modify value type objects in array at specific index
    public mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) throws -> ()) rethrows {
        var element = self[index]
        try modifyElement(&element)
        self[index] = element
    }
    
    /// Helper method to enumerate all objects in array together with index
    public func enumerateForEach(_ body: (_ index: Index, _ element: Element) throws -> ()) rethrows {
        for index in indices {
            try body(index, self[index])
        }
    }
    
    /// Helper method to map all objects in array together with index
    public func enumerateMap<T>(_ body: (_ index: Index, _ element: Element) throws -> T) rethrows -> [T] {
        var map: [T] = []
        for index in indices {
            map.append(try body(index, self[index]))
        }
        
        return map
    }
    
    /// Helper methods to remove object using closure
    @discardableResult public mutating func remove(_ body: (_ element: Element) throws -> Bool) rethrows -> Element? {
        guard let index = try index(where: body) else { return nil }
        
        return remove(at: index)
    }
    
    /// Helper method to filter out duplicates. Element will be filtered out if closure return true.
    public func filterDuplicates(_ includeElement: (_ lhs: Element, _ rhs: Element) throws -> Bool) rethrows -> [Element] {
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
    
    mutating func move(from: Index, to: Index) {
        let element = remove(at: from)
        insert(element, at: to)
    }
}

//-----------------------------------------------------------------------------
// MARK: - Splitting
//-----------------------------------------------------------------------------

public extension Array {
    /// Splits array into slices of specified size
    public func splittedArray(splitSize: Int) -> [[Element]] {
        if self.count <= splitSize {
            return [self]
        } else {
            return [Array<Element>(self[0..<splitSize])] + splittedArray(Array<Element>(self[splitSize..<self.count]), splitSize: splitSize)
        }
    }
    
    private func splittedArray<T>(_ s: [T], splitSize: Int) -> [[T]] {
        if s.count <= splitSize {
            return [s]
        } else {
            return [Array<T>(s[0..<splitSize])] + splittedArray(Array<T>(s[splitSize..<s.count]), splitSize: splitSize)
        }
    }
}
