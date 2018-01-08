//
//  UIViewController+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 28/05/16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Navigation

public extension UIViewController {
    /// Previous view controller in navigation stack
    public var previous: UIViewController? {
        guard let navigationVcs = navigationController?.viewControllers, let currentVcIndex = navigationVcs.index(of: self) else { return nil }
        
        let previousIndex = currentVcIndex - 1
        if previousIndex >= 0 {
            return navigationVcs[previousIndex]
        } else {
            return nil
        }
    }
    
    /// Goes down presentation chain and returns root view controller that presents whole chain.
    public var rootPresentingViewController: UIViewController? {
        var rootPresentingViewController = presentingViewController
        while let presentingVc = rootPresentingViewController?.presentingViewController {
            rootPresentingViewController = presentingVc
        }
        
        return rootPresentingViewController
    }
    
    public var isBeingRemoved: Bool {
        return isMovingFromParentViewController || isBeingDismissed || (navigationController?.isBeingDismissed ?? false)
    }
    
    /// Remove view controller animated action. Removes using pop if it was pushed or using dismiss if it was presented.
    @IBAction func remove(sender: Any) {
        remove(animated: true)
    }
    
    /// Removes view controller using pop if it was pushed or using dismiss if it was presented.
    public func remove(animated: Bool, completion: (() -> Swift.Void)? = nil) {
        if isViewLoaded {
            view.endEditing(true)
        }
        
        if navigationController?.viewControllers.first == self {
            dismiss(animated: animated, completion: completion)
        } else if navigationController?.viewControllers.last == self {
            navigationController?.popViewController(animated: true)
            completion?()
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: completion)
        }
    }
    
    /// Removes all presented view controllers and navigates to the root.
    public func removeToTheRoot(animated: Bool, completion: (() -> Swift.Void)? = nil) {
        if let rootPresentingViewController = rootPresentingViewController {
            let _navigationVc = rootPresentingViewController.navigationController ?? rootPresentingViewController as? UINavigationController
            if let navigationVc = _navigationVc {
                if animated, let window = view.window {
                    // Dismiss and pop animations together. Create overlay and animate it instead to prevent transition warning.
                    let imageVc = UIViewController()
                    imageVc.modalPresentationStyle = .overFullScreen
                    let overlayImage = window.getSnapshotImage()
                    let imageView = UIImageView(image: overlayImage)
                    imageVc.view.backgroundColor = .clear
                    imageView.frame = imageVc.view.bounds
                    
                    // Place image view as window overlay first to hide controllers transitions
                    window.addSubview(imageView)
                    
                    // Dismiss first
                    rootPresentingViewController.dismiss(animated: false) {
                        // Pop next
                        navigationVc.popToRootViewController(animated: false)
                        
                        // Show overlay after
                        imageVc.view.addSubview(imageView)
                        window.rootViewController?.present(imageVc, animated: false) {
                            // Dismiss overlay
                            imageVc.dismiss(animated: true, completion: completion)
                        }
                    }
                    
                } else {
                    // Remove without animations
                    rootPresentingViewController.dismiss(animated: false)
                    navigationVc.popToRootViewController(animated: false)
                }
                
            } else {
                // Just dismiss
                rootPresentingViewController.dismiss(animated: animated, completion: completion)
            }
            
        } else {
            // Just pop
            navigationController?.popToRootViewController(animated: true)
            completion?()
        }
    }
}

// ******************************* MARK: - Editing

public extension UIViewController {
    /// End editing in viewController's view
    @IBAction func endEditing(_ sender: Any) {
        view.endEditing(true)
    }
}
