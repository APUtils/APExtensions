//
//  UITextView+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/27/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UITextView {
    /// Scale font for screen
    @IBInspectable var fitSize: Bool {
        get {
            return false
        }
        set {
            guard newValue else { return; }
            
            font = font?.screenFitFont
        }
    }
}
