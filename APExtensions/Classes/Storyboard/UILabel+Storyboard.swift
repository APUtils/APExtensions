//
//  UILabel+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 22.02.16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


private var defaultFontAssociationKey = 0


extension UILabel {
    private var defaultFont: UIFont? {
        get {
            return objc_getAssociatedObject(self, &defaultFontAssociationKey) as? UIFont
        }
        set {
            objc_setAssociatedObject(self, &defaultFontAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Scale title font for screen
    @IBInspectable open var fitScreenSize: Bool {
        get {
            return defaultFont != nil
        }
        set {
            if newValue {
                defaultFont = font
                font = font.screenFitFont
            } else {
                // Restore
                if let defaultFont = defaultFont {
                    font = defaultFont
                    self.defaultFont = nil
                }
            }
        }
    }
    
    /// Makes font scalable depending on device content size category
    @available(iOS 11.0, *)
    @IBInspectable
    open var scalable: Bool {
        @available(*, unavailable)
        get { return false }
        set {
            if newValue {
                font = font.scalable
                adjustsFontForContentSizeCategory = true
            } else {
                adjustsFontForContentSizeCategory = false
            }
        }
    }
}
