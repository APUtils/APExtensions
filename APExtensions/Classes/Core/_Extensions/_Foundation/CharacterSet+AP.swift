//
//  CharacterSet+AP.swift
//  Pods
//
//  Created by Anton Plebanovich on 31.03.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension CharacterSet {
    
#if DEBUG
    func printDescription() {
        let array = asArray()
        print("Count: \(array.count)")
        for scalar in array {
            print("\(scalar) (U+\(String(scalar.value, radix: 16, uppercase: true)))")
        }
    }
    
    func asArray() -> [Unicode.Scalar] {
        var array = [Unicode.Scalar]()
        for codePoint in (0 as UInt32) ... 0x10FFFF {
            if let scalar = Unicode.Scalar(codePoint),
               self.contains(scalar) {
                array.append(scalar)
            }
        }
        return array
    }
#endif
    
    func containsUnicodeScalars(of character: Character) -> Bool {
        return character.unicodeScalars.allSatisfy(contains(_:))
    }
}
