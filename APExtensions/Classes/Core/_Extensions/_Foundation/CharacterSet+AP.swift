//
//  CharacterSet+AP.swift
//  Pods
//
//  Created by Anton Plebanovich on 31.03.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension CharacterSet {
    
    func containsUnicodeScalars(of character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy(contains(_:))
    }
}
