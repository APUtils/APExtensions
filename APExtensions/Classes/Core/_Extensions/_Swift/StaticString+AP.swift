//
//  StaticString+AP.swift
//  Pods
//
//  Created by Anton Plebanovich on 20.11.23.
//  Copyright © 2023 Anton Plebanovich. All rights reserved.
//

public extension StaticString {
    
    /// Transforms static string to a `String`.
    func toString() -> String {
        withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}
