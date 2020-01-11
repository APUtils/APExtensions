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

// ******************************* MARK: - Pixel Operations

infix operator .== : ComparisonPrecedence
infix operator .!= : ComparisonPrecedence
infix operator .< : ComparisonPrecedence
infix operator .> : ComparisonPrecedence
infix operator .<= : ComparisonPrecedence
infix operator .>= : ComparisonPrecedence
public extension CGFloat {
    
    /// Checks whether two `CGFloat` values corresponds to the same pixel.
    static func .== (lhs: CGFloat, rhs: CGFloat) -> Bool {
        let scale = UIScreen.main.scale
        let lhsPixel = (lhs * scale).rounded()
        let rhsPixel = (rhs * scale).rounded()
        return lhsPixel == rhsPixel
    }
    
    /// Checks whether two `CGFloat` values doesn't correspond to the same pixel.
    static func .!= (lhs: CGFloat, rhs: CGFloat) -> Bool {
        return !(lhs .== rhs)
    }
    
    /// Checks whether two `CGFloat` values doesn't correspond to the same pixel and the left one is smaller.
    static func .< (lhs: CGFloat, rhs: CGFloat) -> Bool {
        return lhs .!= rhs && lhs < rhs
    }
    
    /// Checks whether two `CGFloat` values doesn't correspond to the same pixel and the left one is bigger.
    static func .> (lhs: CGFloat, rhs: CGFloat) -> Bool {
        return lhs .!= rhs && lhs > rhs
    }
    
    /// Checks whether two `CGFloat` values corresponds to the same pixel or the left one is smaller.
    static func .<= (lhs: CGFloat, rhs: CGFloat) -> Bool {
        return (lhs .== rhs) || (lhs < rhs)
    }
    
    /// Checks whether two `CGFloat` values corresponds to the same pixel or the left one is bigger.
    static func .>= (lhs: CGFloat, rhs: CGFloat) -> Bool {
        return (lhs .== rhs) || (lhs > rhs)
    }
}

public extension CGFloat {
    
    /// Returns value raunded to a nearest pixel
    var roundedToPixel: CGFloat {
        let scale = UIScreen.main.scale
        return (self * scale).rounded() / scale
    }
    
    /// Returns value raunded to a nearest up pixel
    var roundedUpToPixel: CGFloat {
        let scale = UIScreen.main.scale
        return (self * scale).rounded(.up) / scale
    }
}
