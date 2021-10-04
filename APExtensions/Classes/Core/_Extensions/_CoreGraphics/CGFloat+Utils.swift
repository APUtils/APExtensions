//
//  CGFloat+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/1/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import CoreGraphics

// ******************************* MARK: - As String

public extension CGFloat {
    
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
        asDouble.asString
    }
}

// ******************************* MARK: - As

public extension CGFloat {
    
    /// Returns `self` as `Int` if possible
    var asInt: Int? { Int(exactly: rounded()) }
    
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
