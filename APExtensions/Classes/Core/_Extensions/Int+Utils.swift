//
//  Int+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/5/19.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension Int {
    
    /// Returns whether number is even
    var isEven: Bool {
        return self % 2 == 0
    }
    
    /// Returns whether number is odd
    var isOdd: Bool {
        return self % 2 == 1
    }
}
