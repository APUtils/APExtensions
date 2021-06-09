//
//  UINavigationController+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/6/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UINavigationController {
    /// Root view controller
    var rootViewController: UIViewController {
        return viewControllers.first!
    }
    
    /// Pushes view controller animated
    func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }
    
    /// Pops view controller animated
    func popViewController() {
        popViewController(animated: true)
    }
}

// ******************************* MARK: - Completion

public extension UINavigationController {
    /// Pushes view controller with completion
    func pushViewController(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        pushViewController(viewController, animated: animated)
        handleCompletion(animated: animated, completion: completion)
    }
    
    /// Pops view controller with completion
    func popViewController(animated: Bool = true, completion: (() -> Void)?) {
        popViewController(animated: animated)
        handleCompletion(animated: animated, completion: completion)
    }
    
    /// Pops to view controller with completion
    func popToViewController(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        popToViewController(viewController, animated: animated)
        handleCompletion(animated: animated, completion: completion)
    }
    
    /// Pops view controller if it present in navigation stack and all overlaying view controllers.
    /// Do nothing if view controller is not in navigation stack.
    func pop(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        if viewControllers.last == viewController {
            // Last controller in stack. Just dismiss it.
            popViewController(animated: animated, completion: completion)
        } else {
            // Not last controller in stack. Pop view controller together with overlaying controllers.
            guard let index = viewControllers.firstIndex(of: viewController) else {
                completion?()
                return
            }
            
            let newViewControllers = Array(viewControllers.prefix(upTo: index))
            setViewControllers(newViewControllers, animated: animated, completion: completion)
        }
    }
    
    /// Pops to root with completion
    func popToRootViewController(animated: Bool = true, completion: (() -> Void)?) {
        popToRootViewController(animated: animated)
        handleCompletion(animated: animated, completion: completion)
    }
    
    /// Replaces view controllers with completion
    func setViewControllers(_ vcs: [UIViewController], animated: Bool = true, completion: (() -> Void)?) {
        setViewControllers(vcs, animated: animated)
        handleCompletion(animated: animated, completion: completion)
    }
    
    /// Replaces last view controller with completion
    func replaceLast(_ vc: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        var vcs = viewControllers
        vcs.removeLast()
        vcs.append(vc)
        
        setViewControllers(vcs, animated: animated, completion: completion)
    }
    
    private func handleCompletion(animated: Bool = true, completion: (() -> Void)?) {
        if animated, let coordinator = transitionCoordinator {
            let success = coordinator.animate(alongsideTransition: nil, completion: { _ in completion?() })
            if !success {
                completion?()
            }
            
        } else {
            completion?()
        }
    }
}
