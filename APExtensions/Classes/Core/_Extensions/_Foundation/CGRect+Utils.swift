//
//  CGRect+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 5/25/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


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
}
