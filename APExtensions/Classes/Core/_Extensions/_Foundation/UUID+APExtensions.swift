//
//  UUID+APExtensions.swift
//  Pods
//
//  Created by Anton Plebanovich on 1.02.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension UUID {
    
    /// `00000000-0000-0000-0000-000000000000`
    static let zero: UUID = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    
    /// `true` if `self` is `00000000-0000-0000-0000-000000000000`
    var isZero: Bool {
        self == Self.zero
    }
    
    /// Returns `uuidString` without hyphens
    var uuidStringWithoutHyphens: String {
        uuidString.replacingOccurrences(of: "-", with: "")
    }
}
