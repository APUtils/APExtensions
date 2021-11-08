//
//  UIEdgeInsets+Extension.swift
//  APExtensions-example
//
//  Created by Anton Plebanovich on 8.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation
import UIKit

public extension UIEdgeInsets {
    
    /// - Parameters:
    ///   - t: Top
    ///   - l: Left
    ///   - b: Bottom
    ///   - r: Right
    init(t: CGFloat = 0, l: CGFloat = 0, b: CGFloat = 0, r: CGFloat = 0) {
        self.init(top: t, left: l, bottom: b, right: r)
    }
    
    /// - returns: Screen resized insets.
    ///
    /// Please check [screenResizeCoef](x-source-tag://screenResizeCoef) for more details 
    var screenResized: UIEdgeInsets {
        modify { $0.screenResized }
    }
    
    /// Modifies each inset using `transform`.
    /// - Parameter transform: Transform to apply for each inset.
    /// - Returns: Modified insets.
    func modify(_ transform: (CGFloat) -> CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: transform(top),
                     left: transform(left),
                     bottom: transform(bottom),
                     right: transform(right))
    }
}
