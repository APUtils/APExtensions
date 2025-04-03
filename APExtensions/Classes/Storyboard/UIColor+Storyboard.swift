//
//  UIColor+Storyboard.swift
//  Pods
//
//  Created by Anton Plebanovich on 3.04.25.
//  Copyright © 2025 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Color Resolution

extension UIColor {
    
    func _applicationResolvedColor(viewController: UIViewController, file: String = #file, function: String = #function, line: UInt = #line) -> UIColor {
        guard #available(iOS 13.0, *) else { return self }
        
        if viewController._window != nil {
            return resolvedColor(with: viewController.traitCollection)
        } else if let window = UIApplication.shared.delegate?.window ?? nil {
            return resolvedColor(with: window.traitCollection)
        } else {
            return resolvedColor(with: viewController.traitCollection)
        }
    }
    
    /// Resolves color using application's delegate window if `view` is not yet added to `window`
    func _applicationResolvedColor(view: UIView? = nil, file: String = #file, function: String = #function, line: UInt = #line) -> UIColor {
        guard #available(iOS 13.0, *) else { return self }
        
        if let view, view.window != nil {
            return resolvedColor(with: view.traitCollection)
        } else if let window = UIApplication.shared.delegate?.window ?? nil {
            return resolvedColor(with: window.traitCollection)
        } else if let view {
            return resolvedColor(with: view.traitCollection)
        } else {
            return resolvedColor(with: UITraitCollection.current)
        }
    }
}
