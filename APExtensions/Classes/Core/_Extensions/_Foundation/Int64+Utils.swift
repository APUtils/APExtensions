//
//  Int64+Utils.swift
//  Pods
//
//  Created by Anton Plebanovich on 6.06.22.
//  Copyright © 2022 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Is

public extension Int64 {
    
    /// Returns whether number is even
    var isEven: Bool { self % 2 == 0 }
    
    /// Returns whether number is odd
    var isOdd: Bool { self % 2 == 1 }
    
    /// Returns `true` if value end on 1.
    var isSingular: Bool { self % 10 == 1 }
}

// ******************************* MARK: - As

public extension Int64 {
    
    /// Returns `self` as `Int`
    var asInt: Int? { Int(exactly: self) }
    
    /// Returns `self` as `UInt`
    var asUInt: UInt? { UInt(exactly: self) }
    
    /// Returns `self` as `CGFloat`
    var asCGFloat: CGFloat { CGFloat(self) }
    
    /// Returns `self` as `Double`
    var asDouble: Double { Double(self) }
    
    /// Returns `self` as `Float`
    var asFloat: Float { Float(self) }
    
    /// Returns `self` as `String`
    var asString: String { String(self) }
    
    /// Returns `self` as HEX `String` in a format like `0xAABB11`
    var asHexString: String { String(format:"0x%02X", self) }
    
    /// Returns `self` as `TimeInterval`
    var asTimeInterval: TimeInterval { TimeInterval(self) }
}
