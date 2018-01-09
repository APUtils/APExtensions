//
//  UINavigationController+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/6/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UINavigationController {
    /// Root view controller
    public var rootViewController: UIViewController {
        get {
            return viewControllers.first!
        }
    }
    
    /// Pushes view controller with completion
    public func pushViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    /// Pops view controller with completion
    public func popViewController(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// Pops to root with completion
    public func popToRootViewController(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
