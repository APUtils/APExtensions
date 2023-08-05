//
//  AlertController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 4/26/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit
import RoutableLogger

// ******************************* MARK: - Class Implementation

open class AlertController: UIAlertController {
    
    // ******************************* MARK: - Types
    
    public enum PresentationStyle {
        /// Present in separate window
        case window
        
        /// Present in key window from top presented controller
        case topController
    }
    
    // ******************************* MARK: - Classes Properties
    
    public static var presentationStyle: PresentationStyle = .window
    
    // ******************************* MARK: - Private Properties
    
    private lazy var alertWindow: UIWindow? = .createAlert()
    
    private var appearanceCaptureViewController: AppearanceCaptureViewController? {
        alertWindow?.rootViewController as? AppearanceCaptureViewController
    }
    
    // ******************************* MARK: - UIViewController Methods
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if AlertController.presentationStyle == .window {
            view.removeFromSuperview()
            alertWindow?.remove()
            alertWindow = nil
        }
    }
    
    // ******************************* MARK: - Public Methods
    
    public func present(animated: Bool = true, preferredStatusBarStyle: UIStatusBarStyle? = nil, completion: (() -> Void)? = nil) {
        if let preferredStatusBarStyle {
            appearanceCaptureViewController?.customPreferredStatusBarStyle = preferredStatusBarStyle
        }
        
        if let popover = popoverPresentationController {
            // Prevent crash by targeting bottom of the screen
            if popover.sourceView == nil && popover.sourceRect == .zero {
                if AlertController.presentationStyle == .window, let alertWindow = alertWindow {
                    popover.sourceView = alertWindow
                    popover.sourceRect = CGRect(x: alertWindow.bounds.size.width / 2, y: alertWindow.bounds.size.height, width: 0, height: 0)
                } else if let view = g.topViewController?.view {
                    popover.sourceView = view
                    popover.sourceRect = CGRect(x: view.bounds.size.width / 2, y: view.bounds.size.height, width: 0, height: 0)
                } else {
                    RoutableLogger.logError("AlertController: can not get sourceView and sourceRect for presentation", data: ["popoverSourceView": popover.sourceView, "popoverSourceRect": popover.sourceRect, "popover": popover, "presentationStyle": AlertController.presentationStyle, "alertWindow": alertWindow, "topViewController": g.topViewController])
                    return
                }
            }
        }
        
        RoutableLogger.logInfo("Presenting alert with title: <\(title.description)>, message: <\(message.description)>, style: <\(preferredStyle.rawValue)>, actions: \(actions.map { $0.title.description })")
        
        g.performInMain {
            switch AlertController.presentationStyle {
            case .window:
                self.alertWindow?.makeKeyAndVisible()
                self.alertWindow?.rootViewController?.present(self, animated: animated, completion: completion)
                
            case .topController:
                g.topViewController?.present(self, animated: animated, completion: completion)
            }
        }
    }
}
