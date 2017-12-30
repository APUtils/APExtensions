//
//  FileManager+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/12/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension FileManager {
    public func fileExists(at url: URL) -> Bool {
        return fileExists(atPath: url.path)
    }
}
