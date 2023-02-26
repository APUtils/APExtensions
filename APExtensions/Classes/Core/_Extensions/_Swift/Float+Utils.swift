//
//  Float+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/20/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

public extension Float {
    
    /// Return `self` as `Double`.
    var asDouble: Double {
        Double(self)
    }
    
    /// Returns `self` as `Int`
    var asInt: Int? { Int(exactly: rounded()) }
}

// ******************************* MARK: - As String

public extension Float {
    
    /// Returns string representation rounded to tenth
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
    
    /// Returns string representation rounded to thousands
    var asThousandsString: String {
        NumberFormatter.thousands.string(from: self as NSNumber) ?? ""
    }
    
    /// Returns `self` as `String`
    var asString: String {
        String(self)
    }
}

// ******************************* MARK: - Other

public extension Float {
    
    /// Returns `true` if `self` is ceil. Returns `false` otherwise.
    var isCeil: Bool {
        floor(self) == self
    }
    
    func roundTo(precision: Int) -> Float {
        let divisor = pow(10.0, Float(precision))
        return (self * divisor).rounded() / divisor
    }
    
}
