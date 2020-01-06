//
//  Character+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/4/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - As

public extension Character {
    
    /// Returns `self` as `String`
    var asString: String {
        return String(self)
    }
}

// ******************************* MARK: - Other

public extension Character {
    
    /// Checks if symbol is in upper case
    var isUppercase: Bool {
        return String(self) == String(self).uppercased()
    }
}
