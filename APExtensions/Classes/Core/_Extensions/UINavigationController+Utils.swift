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
}

// ******************************* MARK: - Completion

public extension UINavigationController {
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
    
    /// Replaces view controllers with completion
    public func setViewControllers(_ vcs: [UIViewController], animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        setViewControllers(vcs, animated: animated)
        CATransaction.commit()
    }
    
    /// Replaces last view controller with completion
    public func replaceLast(_ vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
        var vcs = viewControllers
        vcs.removeLast()
        vcs.append(vc)
        
        setViewControllers(vcs, animated: animated, completion: completion)
    }
}
