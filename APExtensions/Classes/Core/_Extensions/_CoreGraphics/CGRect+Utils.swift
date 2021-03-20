//
//  CGRect+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 5/25/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import CoreGraphics

public extension CGRect {
    /// Center point
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin.x = newValue.x - width / 2
            origin.y = newValue.y - height / 2
        }
    }
    
    /// Returns new rect rounded to a nearest pixel.
    var roundedToPixel: CGRect {
        return CGRect(x: origin.x.roundedToPixel,
                      y: origin.y.roundedToPixel,
                      width: size.width.roundedToPixel,
                      height: size.height.roundedToPixel)
    }
}
