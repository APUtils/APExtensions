//
//  UIFont+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/20/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit
import RoutableLogger

public extension UIFont {
    
    /// Returns screen scaled font. Assuming source font is for 2208x1242 screen.
    var screenFitFont: UIFont {
        var newFontSize = pointSize * c.screenResizeCoef
        newFontSize = newFontSize.rounded()
        
        return UIFont(descriptor: fontDescriptor, size: newFontSize)
    }
    
    /// Returns scalable font depending on device content size category
    @available(iOS 11.0, *)
    var scalable: UIFont {
        let style: UIFont.TextStyle
        switch pointSize {
        case 34...: style = .largeTitle
        case 28..<34: style = .title1
        case 22..<28: style = .title2
        case 20..<22: style = .title3
        case 17..<20: style = .body
        case 16..<17: style = .callout
        case 15..<16: style = .subheadline
        case 13..<15: style = .footnote
        case 12..<13: style = .caption1
        case ..<12: style = .caption2
            
        default:
            RoutableLogger.logError("Unexpected default case", data: ["pointSize": pointSize])
            style = .body
        }
        
        return UIFontMetrics(forTextStyle: style).scaledFont(for: self)
    }
}
