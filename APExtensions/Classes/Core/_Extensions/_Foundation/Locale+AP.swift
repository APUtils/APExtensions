//
//  Locale+AP.swift
//  Pods
//
//  Created by Anton Plebanovich on 11.03.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension Locale {
    
    /// `en_US_POSIX` locale. Useful to make date and number formatters constant.
    /// Should be used internally, e.g. for logs.
    static let posix: Locale = Locale(identifier: "en_US_POSIX")
    
}
