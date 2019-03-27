//
//  UIPopoverController+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/15/19.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension UIPopoverController {
    /// Tries to automatically detect pressed button and present from it on iPads.
    /// Presents nothing if detection failed or it's iPhone.
    func present(animated: Bool = true) {
        let _origin: UIView?
        let window: UIWindow?
        if let _window = UIApplication.shared.keyWindow {
            window = _window
        } else if let _window = UIApplication.shared.delegate?.window ?? nil {
            window = _window
        } else {
            window = nil
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Try to find pressed button on iPads
            _origin = window?.allSubviews
                .compactMap { $0 as? UIButton }
                .first { $0.isHighlighted }
        } else {
            print("UIPopoverController can't be presented on iPhones")
            return
        }
        
        guard let origin = _origin else {
            print("Unable to automatically detect origin")
            return
        }
        
        present(from: origin.bounds, in: origin, permittedArrowDirections: .any, animated: animated)
    }
}
