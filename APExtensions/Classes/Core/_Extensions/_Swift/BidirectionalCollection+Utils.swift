//
//  BidirectionalCollection+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9.10.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

// ******************************* MARK: - As

public extension BidirectionalCollection {
    
    /// When there is only one element, returns that element
    var asSingular: Element? {
        guard count == 1 else { return nil }
        return first
    }
}

// ******************************* MARK: - Index

public extension BidirectionalCollection {
    
    /// Second index
    var secondIndex: Index? {
        guard count > 1 else { return nil }
        return index(after: startIndex)
    }
    
    /// Second element in array
    var second: Element? {
        guard let secondIndex = secondIndex else { return nil }
        return self[secondIndex]
    }
    
    /// Third index
    var thirdIndex: Index? {
        guard count > 2, let secondIndex = secondIndex else { return nil }
        return index(after: secondIndex)
    }
    
    /// Third element in a collection
    var third: Element? {
        guard let thirdIndex = thirdIndex else { return nil }
        return self[thirdIndex]
    }
    
    /// Fourth index
    var fourthIndex: Index? {
        guard count > 3, let thirdIndex = thirdIndex else { return nil }
        return index(after: thirdIndex)
    }
    
    /// Fourth element in a collection
    var fourth: Element? {
        guard let fourthIndex = fourthIndex else { return nil }
        return self[fourthIndex]
    }
}
