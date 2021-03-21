//
//  RandomAccessCollection+Utils.swift
//  APExtensions-example
//
//  Created by Anton Plebanovich on 3/21/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

public extension RandomAccessCollection {
    
    /// Returns the position immediately after the given index. Returns `nil` if index is out of bounds.
    ///
    /// - Parameter i: A valid index of the collection.
    /// - Returns: The index immediately after `i`.
    @inlinable
    func existingIndex(after i: Index) -> Index? {
        guard indices.contains(i) else { return nil }
        
        let afterIndex = index(after: i)
        if afterIndex < endIndex {
            return afterIndex
        } else {
            return nil
        }
    }
}
