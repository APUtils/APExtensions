//
//  Character+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/4/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension Character {
    var isUpperCase: Bool {
        return String(self) == String(self).uppercased()
    }
}
