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
        
        if #available(iOS 10.0, *) {
            shared.open(url, options: [:], completionHandler: nil)
        } else {
            shared.openURL(url)
        }
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

// ******************************* MARK: - Window

public extension UIApplication {
    
    /// Returns the first key window across all connected scenes
    var firstKeyWindow: UIWindow? {
        if #available(iOS 15.0, *) {
            return connectedScenes
                .compactMap {
                    ($0 as? UIWindowScene)?.keyWindow
                }
                .first
            
        } else if #available(iOS 13.0, *) {
            return connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
            
        } else {
            return keyWindow
        }
    }
}

// ******************************* MARK: - UIApplication.State - CustomStringConvertible

extension UIApplication.State: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .active: return "active"
        case .background: return "background"
        case .inactive: return "inactive"
        @unknown default: return "unknown"
        }
    }
}
