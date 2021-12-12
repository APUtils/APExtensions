//
//  KeyPath+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12.12.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

public extension AnyKeyPath {
    
    /// Returns key path as string
    var asString: String? {
        _kvcKeyPathString?.description
    }
}
