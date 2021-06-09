//
//  UIFont+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/20/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

public extension UIFont {
    /// Returns screen scaled font. Assuming source font is for 2208x1242 screen.
    var screenFitFont: UIFont {
        let baseScreenSize: CGFloat = 414 // iPhone 6+
        let currentScreenSize = UIScreen.main.bounds.width
        let fontResizeCoef = currentScreenSize / baseScreenSize
        var newFontSize = pointSize * fontResizeCoef
        newFontSize = newFontSize.rounded(.toNearestOrEven)
        
        return UIFont(descriptor: fontDescriptor, size: newFontSize)
    }
    
    
    // TODO: Add Dynamic Type with UIFontMetrics for iOS 11
}
