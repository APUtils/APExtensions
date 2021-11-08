//
//  UIWindow+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/9/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit
import RoutableLogger

public extension UIWindow {
    /// Creates new alert window with AppearanceCaptureViewController as rootViewController
    static func createAlert() -> UIWindow {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.windowLevel = .alert
        alertWindow.rootViewController = AppearanceCaptureViewController()
        
        return alertWindow
    }
    
    /// Creates new normal window with AppearanceCaptureViewController as rootViewController
    static func createNormal() -> UIWindow {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.windowLevel = .normal
        alertWindow.rootViewController = AppearanceCaptureViewController()
        
        return alertWindow
    }
    
    /// Removes window from windows stack
    func remove() {
        RoutableLogger.logDebug("Removing '\(g.getPointer(self))' window")
        
        /// During VC remove if it was presented in a window Motion
        /// adds `AppearanceCaptureViewController`'s view to the app window
        /// while we transition in the separate window. This causes
        /// this view to block view hierarchy in the main window.
        /// Removing it here manually.
        rootViewController?.view.removeFromSuperview()
        rootViewController = nil
        isHidden = true
        
        // https://stackoverflow.com/a/59988501/4124265
        if #available(iOS 13.0, *) {
            windowScene = nil
        }
    }
}
