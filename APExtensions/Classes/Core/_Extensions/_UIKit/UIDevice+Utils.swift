//
//  UIDevice+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/21/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    /// Returns a current device version.
    static var currentDeviceSystemVersion: Version {
        Version(current.systemVersion)
    }
}
