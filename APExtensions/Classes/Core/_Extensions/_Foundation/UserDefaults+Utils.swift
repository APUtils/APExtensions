//
//  UserDefaults+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/13/19.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension UserDefaults {
    /// Wheter UserDefaults has the object for the key
    func hasObject(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
