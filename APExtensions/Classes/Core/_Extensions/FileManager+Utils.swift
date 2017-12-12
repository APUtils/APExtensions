//
//  FileManager+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/12/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import Foundation


extension FileManager {
    func fileExists(url: URL) -> Bool {
        return fileExists(atPath: url.path)
    }
}
