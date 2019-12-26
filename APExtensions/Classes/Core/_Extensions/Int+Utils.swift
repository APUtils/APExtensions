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
    
    /// Returns `true` if value end on 1.
    var isSingular: Bool {
        return self % 10 == 1
    }
}

// ******************************* MARK: - As

public extension Int {
    
    /// Returns `self` as `Double`
    var asDouble: Double {
        return Double(self)
    }
    
    /// Returns `self` as `Float`
    var asFloat: Float {
        return Float(self)
    }
    
    /// Returns `self` as `String`
    var asString: String {
        return String(self)
    }
    
    /// Returns `self` as `TimeInterval`
    var asTimeInterval: TimeInterval {
        return TimeInterval(self)
    }
}
