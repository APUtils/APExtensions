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

// ******************************* MARK: - ID

public extension UIDevice {
    
    /// UUID string which uniquely identifies the current device.
    private(set) static var distinctID: String = userDefaultsDistinctID
    
    private static let userDefaultKey = "APExtensions_UIDevice_distinctID"
    
    private static var userDefaultsDistinctID: String {
        get {
            if let value = UserDefaults.standard.string(forKey: userDefaultKey) {
                return value
            } else {
                let value = generateDistinctID()
                UserDefaults.standard.set(value, forKey: userDefaultKey)
                return value
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultKey)
        }
    }
    
    private static func generateDistinctID() -> String {
        let uuid = current.identifierForVendor ?? UUID()
        return uuid.uuidString
    }
}

// ******************************* MARK: - UIDevice.BatteryState - CustomStringConvertible

extension UIDevice.BatteryState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .charging: return "charging"
        case .full: return "full"
        case .unknown: return "unknown"
        case .unplugged: return "unplugged"
        @unknown default: return "undefined"
        }
    }
}

// ******************************* MARK: - Other

public extension UIDevice {
    
    /// Current device is a simulator
    static let isSimulator: Bool = {
        TARGET_OS_SIMULATOR != 0
    }()
    
    /// Current device is a real device
    static let isReal: Bool = {
        TARGET_OS_SIMULATOR == 0
    }()
}
