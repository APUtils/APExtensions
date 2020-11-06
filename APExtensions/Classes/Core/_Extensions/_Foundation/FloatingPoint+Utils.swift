//
//  FloatingPoint+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/3/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Checks

public extension FloatingPoint {
    
    /// Checks if `self` is whole number.
    var isWhole: Bool {
        return truncatingRemainder(dividingBy: 1) == 0
    }
}
