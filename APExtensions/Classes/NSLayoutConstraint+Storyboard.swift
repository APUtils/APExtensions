//
//  NSLayoutConstraint+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/12/17.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import Foundation


private let roundConstantSize = false


public extension NSLayoutConstraint {
    
    /// Scale constraint constant to fit screen. Assuming source font is for 2208x1242 screen.
    @IBInspectable public var fitScreenSize: Bool {
        get {
            // TODO: Add associated value to store old value
            return false
        }
        set {
            let baseScreenSize: CGFloat = 414 // iPhone 6+
            let currentScreenSize = UIScreen.main.bounds.width
            let resizeCoef = currentScreenSize / baseScreenSize
            var newConstant = constant * resizeCoef
            if roundConstantSize {
                newConstant = newConstant.rounded(.toNearestOrEven)
            }
            
            constant = newConstant
        }
    }
}
