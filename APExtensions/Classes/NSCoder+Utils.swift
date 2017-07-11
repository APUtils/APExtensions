//
//  NSCoder+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/4/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension NSCoder {
    public func decodeString(forKey key: String, defaultValue: String) -> String {
        return (decodeObject(forKey: key) as? String) ?? defaultValue
    }
}
