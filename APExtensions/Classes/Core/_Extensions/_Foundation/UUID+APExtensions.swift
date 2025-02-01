//
//  UUID+APExtensions.swift
//  Pods
//
//  Created by Anton Plebanovich on 1.02.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension UUID {
    
    /// Returns `uuidString` without hyphens
    var uuidStringWithoutHyphens: String {
        uuidString.replacingOccurrences(of: "-", with: "")
    }
}
