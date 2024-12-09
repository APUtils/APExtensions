//
//  CGRect+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 5/25/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import CoreGraphics

public extension CGRect {
    /// Center point
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin.x = newValue.x - width / 2
            origin.y = newValue.y - height / 2
        }
    }
    
    /// Assumes it's popover source rect and checks its validity
    var isInvalidPopoverSourceRect: Bool {
        isNull || isInfinite || self == .zero
    }

    /// Returns new rect rounded to a nearest pixel value using the specified rounding rule.
    /// Uses `.toNearestOrAwayFromZero` by default.
    /// - returns: The integral value found by rounding using rule. 
    func roundedToPixel(_ rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> CGRect {
        return CGRect(x: origin.x.roundedToPixel(rule),
                      y: origin.y.roundedToPixel(rule),
                      width: size.width.roundedToPixel(rule),
                      height: size.height.roundedToPixel(rule))
    }
}
