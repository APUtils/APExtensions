//
//  UILayoutPriority+AP.swift
//  Pods
//
//  Created by Anton Plebanovich on 7.01.24.
//  Copyright © 2024 Anton Plebanovich. All rights reserved.
//

import UIKit

extension UILayoutPriority: @retroactive ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self.init(value)
    }
}

extension UILayoutPriority: @retroactive ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value.asFloat)
    }
}
