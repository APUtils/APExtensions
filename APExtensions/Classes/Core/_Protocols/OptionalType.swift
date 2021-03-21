//
//  OptionalType.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/4/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

// Take from https://github.com/RxSwiftCommunity/RxOptional/blob/master/Sources/RxOptional/OptionalType.swift
// Originally from here: https://github.com/artsy/eidolon/blob/24e36a69bbafb4ef6dbe4d98b575ceb4e1d8345f/Kiosk/Observable%2BOperators.swift#L30-L40
// Credit to Artsy and @ashfurrow
public protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    /// Cast `Optional<Wrapped>` to `Wrapped?`
    public var value: Wrapped? { self }
}

public extension Sequence where Element: OptionalType {
    
    // Filter optional values from a sequence and return non-optional array of non-nil elements
    func filterNil() -> [Element.Wrapped] { compactMap { $0.value } }
}
