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
        var newFontSize = pointSize * c.screenResizeCoef
        newFontSize = newFontSize.rounded()
        
        return UIFont(descriptor: fontDescriptor, size: newFontSize)
    }
    
    
    // TODO: Add Dynamic Type with UIFontMetrics for iOS 11
}
