//
//  Float+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/20/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension Float {
    
    /// Return `self` as `Double`.
    var asDouble: Double {
        Double(self)
    }
    
    /// Returns `self` as `Int`
    var asInt: Int? { Int(exactly: self) }
}

// ******************************* MARK: - As String

public extension Float {
    
    /// Returns string representation rounded to tenth
    var asCeilString: String {
        String(format: "%.0f", self)
    }
    
    /// Returns string representation rounded to tenth
    var asTenthString: String {
        String(format: "%.1f", self)
    }
    
    /// Returns string representation rounded to hundredth
    var asHundredthString: String {
        String(format: "%.2f", self)
    }
    
    /// Returns string representation rounded to thousands
    var asThousandsString: String {
        String(format: "%.3f", self)
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
