//
//  CGFloat+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/1/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - As String

public extension CGFloat {
    
    /// Returns `self` as `String`
    var asString: String {
        return asDouble.asString
    }
    
    /// Returns string representation rounded to tenth
    var asTenthString: String {
        return String(format: "%.1f", self)
    }
    
    /// Returns string representation rounded to hundredth
    var asHundredthString: String {
        return String(format: "%.2f", self)
    }
}

// ******************************* MARK: - As

public extension CGFloat {
    
    /// Returns `self` as `Int` if possible
    var asInt: Int? {
        if self >= Int.min.asCGFloat, self < Int.max.asCGFloat {
            return Int(self)
        } else {
            return nil
        }
    }
    
    /// Returns `self` as `Double`
    var asDouble: Double {
        return Double(self)
    }
}
