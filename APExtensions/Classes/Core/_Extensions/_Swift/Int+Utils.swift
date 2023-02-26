//
//  Int+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/5/19.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

// ******************************* MARK: - Is

public extension Int {
    
    /// Returns whether number is even
    var isEven: Bool { self % 2 == 0 }
    
    /// Returns whether number is odd
    var isOdd: Bool { self % 2 == 1 }
    
    /// Returns `true` if value end on 1.
    var isSingular: Bool { self % 10 == 1 }
}

// ******************************* MARK: - As

public extension Int {
    
    /// Returns `self` as `UInt`
    var asUInt: UInt? { UInt(exactly: self) }
    
    /// Returns `self` as `CGFloat`
    var asCGFloat: CGFloat { .init(self) }
    
    /// Returns `self` as `Double`
    var asDouble: Double { .init(self) }
    
    /// Returns `self` as `Float`
    var asFloat: Float { .init(self) }
    
    /// Returns `self` as `String`
    var asString: String { .init(self) }
    
    /// Returns `self` as HEX `String` in a format like `0xAABB11`
    var asHexString: String { .init(format:"0x%02X", self) }
    
    /// Returns `self` as `TimeInterval`
    var asTimeInterval: TimeInterval { .init(self) }
}

// ******************************* MARK: - Other

public extension Int {
    
    /// Makes `self` negative to the current value.
    var negative: Int {
        -self
    }
}
