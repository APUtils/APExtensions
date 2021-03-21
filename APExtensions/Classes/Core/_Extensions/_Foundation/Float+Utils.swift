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
    var asInt: Int? {
        if self >= Int.min.asFloat, self < Int.max.asFloat {
            return Int(self)
        } else {
            return nil
        }
    }
    
    func roundTo(precision: Int) -> Float {
        let divisor = pow(10.0, Float(precision))
        return (self * divisor).rounded() / divisor
    }
}

// ******************************* MARK: - As String

extension Float {
    
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
