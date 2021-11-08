//
//  NSLayoutConstraint.Attribute+Extension.swift
//  APExtensions-example
//
//  Created by Anton Plebanovich on 8.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint.Attribute {
    
    /// Returns `true` if attribute is horizontal.
    var isHorizontal: Bool {
        self == NSLayoutConstraint.Attribute.left
        || self == NSLayoutConstraint.Attribute.leftMargin
        || self == NSLayoutConstraint.Attribute.right
        || self == NSLayoutConstraint.Attribute.rightMargin
        || self == NSLayoutConstraint.Attribute.leading
        || self == NSLayoutConstraint.Attribute.leadingMargin
        || self == NSLayoutConstraint.Attribute.trailing
        || self == NSLayoutConstraint.Attribute.trailingMargin
        || self == NSLayoutConstraint.Attribute.width
        || self == NSLayoutConstraint.Attribute.centerX
        || self == NSLayoutConstraint.Attribute.centerXWithinMargins
    }
    
    /// Returns `true` if attribute is vertical.
    var isVertical: Bool {
        self == NSLayoutConstraint.Attribute.top
        || self == NSLayoutConstraint.Attribute.topMargin
        || self == NSLayoutConstraint.Attribute.bottom
        || self == NSLayoutConstraint.Attribute.bottomMargin
        || self == NSLayoutConstraint.Attribute.height
        || self == NSLayoutConstraint.Attribute.centerY
        || self == NSLayoutConstraint.Attribute.centerYWithinMargins
    }
    
    /// Returns `true` if attribute is to the left side.
    var isLeftSide: Bool {
        if self == NSLayoutConstraint.Attribute.left || self == NSLayoutConstraint.Attribute.leftMargin {
            return true
        }
        
        // TODO: Add support for per view layout direction later if needed
        if UIApplication.shared.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirection.leftToRight {
            return self == NSLayoutConstraint.Attribute.leading || self == NSLayoutConstraint.Attribute.leadingMargin
        } else {
            return self == NSLayoutConstraint.Attribute.trailing || self == NSLayoutConstraint.Attribute.trailingMargin
        }
    }
    
    /// Returns `true` if attribute is to the center X.
    var isCenterX: Bool {
        self == NSLayoutConstraint.Attribute.centerX || self == NSLayoutConstraint.Attribute.centerXWithinMargins
    }
    
    /// Returns `true` if attribute is to the right side.
    var isRightSide: Bool {
        if self == NSLayoutConstraint.Attribute.right || self == NSLayoutConstraint.Attribute.rightMargin {
            return true
        }
        
        // TODO: Add support for per view layout direction later if needed
        if UIApplication.shared.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirection.leftToRight {
            return self == NSLayoutConstraint.Attribute.trailing || self == NSLayoutConstraint.Attribute.trailingMargin
        } else {
            return self == NSLayoutConstraint.Attribute.leading || self == NSLayoutConstraint.Attribute.leadingMargin
        }
    }
    
    /// Returns `true` if attribute is to the top side.
    var isTopSide: Bool {
        self == NSLayoutConstraint.Attribute.top || self == NSLayoutConstraint.Attribute.topMargin
    }
    
    /// Returns `true` if attribute is to the center Y.
    var isCenterY: Bool {
        self == NSLayoutConstraint.Attribute.centerY || self == NSLayoutConstraint.Attribute.centerYWithinMargins
    }
    
    /// Returns `true` if attribute is to the bottom side.
    var isBottomSide: Bool {
        self == NSLayoutConstraint.Attribute.bottom || self == NSLayoutConstraint.Attribute.bottomMargin
    }
}
