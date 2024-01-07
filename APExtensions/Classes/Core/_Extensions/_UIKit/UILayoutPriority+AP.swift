//
//  UILayoutPriority+AP.swift
//  Pods
//
//  Created by Anton Plebanovich on 7.01.24.
//  Copyright © 2024 Anton Plebanovich. All rights reserved.
//

import UIKit

extension UILayoutPriority: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self.init(value)
    }
}

extension UILayoutPriority: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value.asFloat)
    }
}
