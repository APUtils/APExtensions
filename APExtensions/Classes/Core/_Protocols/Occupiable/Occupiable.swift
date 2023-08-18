//
//  Occupiable.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/4/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Declarations

// Taken from https://github.com/RxSwiftCommunity/RxOptional/blob/master/Sources/RxOptional/Occupiable.swift
// Originally from here: https://github.com/artsy/eidolon/blob/f95c0a5bf1e90358320529529d6bf431ada04c3f/Kiosk/App/SwiftExtensions.swift#L23-L40
// Credit to Artsy and @ashfurrow
// Anything that can hold a value (strings, arrays, etc.)
public protocol Occupiable {
    var isEmpty: Bool { get }
    var isNotEmpty: Bool { get }
}

public extension Occupiable {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

public extension Occupiable {
    /// Returns `nil` for empty values.
    /// Otherwise, just returns self.
    var nonEmpty: Self? {
        return isEmpty ? nil : self
    }
}

// ******************************* MARK: - Collection + Occupiable

public extension Collection where Self: Occupiable {
    /// Property equal to `isNotEmpty` property.
    /// Added just because in the case of Collection types, 'hasElements' is more descriptive name
    /// than 'isNotEmpty'.
    var hasElements: Bool { return isNotEmpty }
}

public extension Collection {
    var hasElements: Bool {
        !isEmpty
    }
}

// ******************************* MARK: - Sequence + Occupiable

public extension Sequence where Element: Occupiable {
    /// Returns an array containing, in order, the elements of the sequence filtering out all
    /// empty elements.
    ///
    /// - Returns: An array of non-empty elements with preserved order.
    func filterEmpty() -> [Element] {
        return filter { $0.isNotEmpty }
    }
}

// ******************************* MARK: - Optionals + Occupiable

public extension Optional where Wrapped: Occupiable {
    /// `true` if current occupiable optional is either nil or empty, `false` otherwise.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
    /// `true` if current occupiable optional represents some non-empty value.
    var isNotEmpty: Bool {
        switch self {
        case .none:
            return false
        case .some(let wrapped):
            return wrapped.isNotEmpty
        }
    }
    
    /// Unwraps optional and replaces empty value by `nil`.
    var nonEmpty: Wrapped? {
        switch self {
        case .some(let wrapped):
            return wrapped.nonEmpty
        default:
            return nil
        }
    }
}

public extension Optional where Wrapped: Collection & Occupiable {
    /// Property equal to `isNotEmpty` property.
    /// Added just because in the case of Collection types, 'hasElements' is more descriptive name
    /// than 'isNotEmpty'.
    var hasElements: Bool {
        return isNotEmpty
    }
}

// ******************************* MARK: - InitializeableOccupiable

public protocol InitializeableOccupiable: Occupiable {
    init()
}

// I can't think of a way to combine these collection types. Suggestions welcomed!
extension Array: InitializeableOccupiable {}
extension Data: InitializeableOccupiable {}
extension Dictionary: InitializeableOccupiable {}
extension Set: InitializeableOccupiable {}
extension String: InitializeableOccupiable {}
extension Substring: InitializeableOccupiable {}

@available(iOS 15, *)
extension AttributedString: InitializeableOccupiable {
    public var isEmpty: Bool {
        startIndex == endIndex
    }
}

@available(iOS 15, *)
extension AttributedSubstring: InitializeableOccupiable {
    public var isEmpty: Bool {
        startIndex == endIndex
    }
}

extension NSDictionary: InitializeableOccupiable {
    public var isEmpty: Bool { count < 1 }
}

extension NSSet: InitializeableOccupiable {
    public var isEmpty: Bool { count < 1 }
    
    /// Property equal to `isNotEmpty` property.
    /// Added just because in the case of Collection types, 'hasElements' is more descriptive name
    /// than 'isNotEmpty'.
    public var hasElements: Bool { return isNotEmpty }
}

extension NSOrderedSet: InitializeableOccupiable {
    public var isEmpty: Bool { count < 1 }
    
    /// Property equal to `isNotEmpty` property.
    /// Added just because in the case of Collection types, 'hasElements' is more descriptive name
    /// than 'isNotEmpty'.
    public var hasElements: Bool { return isNotEmpty }
}

extension NSString: InitializeableOccupiable {
    public var isEmpty: Bool { length < 1 }
}

extension NSAttributedString: InitializeableOccupiable {
    public var isEmpty: Bool { length < 1 }
}

public extension Optional where Wrapped: InitializeableOccupiable {
    
    /// Unwraps optional and replaces `nil` value by empty value.
    var nonNil: Wrapped {
        return self ?? Wrapped()
    }
}
