//
//  CGFloat+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/1/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

#if SPM
import APExtensionsShared
#endif
import CoreGraphics
import Foundation
import UIKit

// ******************************* MARK: - As String

public extension CGFloat {
    
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
        asDouble.asString
    }
}

// ******************************* MARK: - As

public extension CGFloat {
    
    /// Returns `self` as `Int` if possible
    var asInt: Int? { Int(exactly: rounded()) }
    
    /// Returns `self` as `Float`
    var asFloat: Float {
        Float(self)
    }
    
    /// Returns `self` as `Double`
    var asDouble: Double {
        return Double(self)
    }
}

// ******************************* MARK: - Other

public extension CGFloat {
    
    /// Returns `true` if `self` is ceil. Returns `false` otherwise.
    var isCeil: Bool {
        floor(self) == self
    }
    
    /// - returns: Screen resized value.
    ///
    /// Please check [screenResizeCoef](x-source-tag://screenResizeCoef) for more details
    var screenResized: CGFloat {
        (self * c.screenResizeCoef).rounded()
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
    
    /// Returns this value rounded to a pixel value using the specified rounding rule.
    /// Uses `.toNearestOrAwayFromZero` by default.
    /// - returns: The integral value found by rounding using rule.
    func roundedToPixel(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> CGFloat {
        let scale = UIScreen.main.scale
        return (self * scale).rounded(rule) / scale
    }
}
