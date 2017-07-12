//
//  UILabel+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 22.02.16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UILabel {
    /// Scale title font for screen
    @IBInspectable var fitSize: Bool {
        get {
            // TODO: Add associated value to store old value
            return false
        }
        set {
            guard newValue else { return; }
            
            font = font.screenFitFont
        }
    }
}
