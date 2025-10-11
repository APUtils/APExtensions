//
//  OperatingSystemVersion+AP.swift
//  Pods
//
//  Created by Anton Plebanovich on 11.10.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension OperatingSystemVersion {
    
    var asVersion: Version {
        Version(major: majorVersion, minor: minorVersion, patch: patchVersion, build: nil)
    }
}
