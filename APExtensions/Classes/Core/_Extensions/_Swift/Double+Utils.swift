//
//  Double+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/26/19.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - As String

public extension Double {
    
    /// Returns string representation rounded to ceil
    var asCeilString: String {
        NumberFormatter.ceil.string(from: self as NSNumber) ?? ""
    }
    
    /// Returns string representation rounded to tenth
    var asTenthString: String {
        NumberFormatter.tenth.string(from: self as NSNumber) ?? ""
    }
    
    /// Returns string representation rounded to hundredth
    var asHundredthString: String {
        NumberFormatter.hundredth.string(from: self as NSNumber) ?? ""
    }
    
    /// Returns string representation rounded to thousandth
    var asThousandthString: String {
        NumberFormatter.thousandth.string(from: self as NSNumber) ?? ""
    }
    
    /// Returns `self` as `String`
    var asString: String {
        String(self)
    }
    
    /// Returns string representation rounded to provided precition
    func asString(precition: UInt) -> String {
        String(format: "%.\(precition)f", self)
    }
}

// ******************************* MARK: - As

public extension Double {
    
    /// Returns `self` as `Float`
    var asFloat: Float {
        Float(self)
    }
    
    /// Returns `self` as `CGFloat`
    var asCGFloat: CGFloat {
        CGFloat(self)
    }
    
    /// Returns `self` as `Date` using `timeIntervalSince1970` representation.
    var asDate: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    /// Returns `self` as `Int` if possible
    var asInt: Int? { Int(exactly: rounded()) }
    
    /// Returns `self` as `Int64` if possible
    var asInt64: Int64? { Int64(exactly: rounded()) }
}

// ******************************* MARK: - Other

public extension Double {
    
    /// Return absolute value of self
    var abs: Double {
        Swift.abs(self)
    }
    
    /// Returns `true` if `self` is ceil. Returns `false` otherwise.
    var isCeil: Bool {
        floor(self) == self
    }
    
}
