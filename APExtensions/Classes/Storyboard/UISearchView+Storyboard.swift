//
//  UISearchView+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8.02.22.
//  Copyright © 2022 Anton Plebanovich. All rights reserved.
//

import UIKit

private var defaultFontAssociationKey = 0

extension UISearchBar {
    
    private var defaultFont: UIFont? {
        get {
            return objc_getAssociatedObject(self, &defaultFontAssociationKey) as? UIFont
        }
        set {
            objc_setAssociatedObject(self, &defaultFontAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Scale title font for screen
    @available(iOS 13.0, *)
    @IBInspectable var fitScreenSize: Bool {
        get {
            return defaultFont != nil
        }
        set {
            if newValue {
                defaultFont = searchTextField.font
                searchTextField.font = searchTextField.font?.screenFitFont
            } else {
                // Restore
                if let defaultFont = defaultFont {
                    searchTextField.font = defaultFont
                    self.defaultFont = nil
                }
            }
        }
    }
    
    /// Makes font scalable depending on device content size category
    @available(iOS 13.0, *)
    @IBInspectable
    var scalable: Bool {
        @available(*, unavailable)
        get { return false }
        set { searchTextField.scalable = newValue }
    }
}
