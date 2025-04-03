//
//  UIViewController+Storyboard.swift
//  Pods
//
//  Created by Anton Plebanovich on 3.04.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Try to get window that owns this view controller.
    var _window: UIWindow? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            if let _nextResponder = nextResponder?.next {
                nextResponder = _nextResponder
            } else if let vc = nextResponder as? UIViewController {
                nextResponder = vc.navigationController
            } else if let window = nextResponder as? UIWindow {
                return window
            } else {
                return nil
            }
        }
        
        return nil
    }
}
