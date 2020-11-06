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
    
    /// Returns `self` as `String`
    var asString: String {
        return String(self)
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

public extension Double {
    
    /// Returns `self` as `Date` using `timeIntervalSince1970` representation.
    var asDate: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    /// Returns `self` as `Int` if possible
    var asInt: Int? {
        if self >= Int.min.asDouble, self < Int.max.asDouble {
            return Int(self)
        } else {
            return nil
        }
    }
}
