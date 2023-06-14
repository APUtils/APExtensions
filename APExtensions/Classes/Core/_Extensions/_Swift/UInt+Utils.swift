//
//  UInt+Utils.swift
//  APExtensions-example
//
//  Created by Anton Plebanovich on 4/3/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import CoreFoundation
import Foundation

public extension UInt {
    
    /// Returns `self` as `Int` if possible
    var asInt: Int? { Int(exactly: self) }
    
    /// Returns `self` as `CGFloat`
    var asCGFloat: CGFloat { .init(self) }
    
    /// Returns `self` as `Double`
    var asDouble: Double { .init(self) }
    
    /// Returns `self` as `Float`
    var asFloat: Float { .init(self) }
    
    /// Returns `self` as `String`
    var asString: String { .init(self) }
    
    /// Returns `self` as HEX `String` in a format like `0xAABB11`
    var asHexString: String { .init(format: "0x%02X", self) }
    
    /// Returns `self` as `TimeInterval`
    var asTimeInterval: TimeInterval { .init(self) }
}
