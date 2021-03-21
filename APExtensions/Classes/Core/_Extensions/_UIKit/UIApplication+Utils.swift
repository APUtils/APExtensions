//
//  UIApplication+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/14/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Phone Call

public extension UIApplication {
    /// Initiates call to `phone`
    static func makeCall(phone: String) {
        let urlString = "telprompt://\(phone)"
        guard let url = URL(string: urlString) else { return }
        
        shared.openURL(url)
    }
}

// ******************************* MARK: - Background Task

private var v_backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid

public extension UIApplication {
    /// Starts background task if app is in background and task is not yet started.
    func startBackgroundTaskIfNeeded() {
        guard UIApplication.shared.applicationState == .background else { return }
        guard v_backgroundTaskIdentifier == .invalid else { return }
        
        v_backgroundTaskIdentifier = beginBackgroundTask {
            self.stopBackgroundTaskIfNeeded()
        }
    }
    
    /// Stops background task if not yet stopped.
    func stopBackgroundTaskIfNeeded() {
        guard v_backgroundTaskIdentifier != .invalid else { return }
        
        endBackgroundTask(v_backgroundTaskIdentifier)
        v_backgroundTaskIdentifier = .invalid
    }
}

// ******************************* MARK: - Tests

public extension UIApplication {
    
    /// Returns `true` if the app is running unit tests and `false` otherwise.
    static let isRunningUnitTests: Bool = ProcessInfo
        .processInfo
        .environment
        .keys
        .contains("XCTestConfigurationFilePath")
}

// ******************************* MARK: - UIApplication.State - CustomStringConvertible

extension UIApplication.State: CustomStringConvertible {
    public var description: String {
        switch self {
        case .active: return "active"
        case .background: return "background"
        case .inactive: return "inactive"
        @unknown default: return "unknown"
        }
    }
}

// ******************************* MARK: - Start Time

extension UIApplication: SetupOnce {
    
    private static let previousStartTimeUserDefaultsKey = "APExtensions_UIApplication_previousStartTime"
    
    /// Previous application start time
    public static var previousStartTime: Date {
        get {
            Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: previousStartTimeUserDefaultsKey))
        }
        set {
            UserDefaults.standard.setValue(newValue.timeIntervalSince1970, forKey: previousStartTimeUserDefaultsKey)
        }
    }
    
    private static let startTimeUserDefaultsKey = "APExtensions_UIApplication_startTime"
    
    /// Application start time
    public static var startTime: Date {
        get {
            Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: startTimeUserDefaultsKey))
        }
        set {
            UserDefaults.standard.setValue(newValue.timeIntervalSince1970, forKey: startTimeUserDefaultsKey)
        }
    }
    
    public static var setupOnce: Int = {
        previousStartTime = startTime
        startTime = Date()
        
        return 0
    }()
}
