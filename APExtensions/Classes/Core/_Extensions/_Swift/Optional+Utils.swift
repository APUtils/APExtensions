//
//  Optional+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 08.08.16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

// ******************************* MARK: - Optional Arrays Equatable

public func ==<T>(lhs: [T]?, rhs: [T]?) -> Bool where T: Equatable {
    switch (lhs, rhs) {
    case (.none, .none): return true
    case (.some(let lhsValue), .some(let rhsValue)): return lhsValue == rhsValue
    default: return false
    }
}

public func !=<T>(lhs: [T]?, rhs: [T]?) -> Bool where T: Equatable {
    switch (lhs, rhs) {
    case (.none, .none): return false
    case (.some(let lhsValue), .some(let rhsValue)): return lhsValue != rhsValue
    default: return true
    }
}

// ******************************* MARK: - CustomStringConvertible

extension Optional: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .some(let value):
            if let description = (value as? CustomStringConvertible)?.description {
                return description
            } else {
                return String(describing: value)
            }
            
        case .none: return "nil"
        }
    }
}
