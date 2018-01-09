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
    
    /// Goes down responder chain and returns window if it exists.
    public var window: UIWindow? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            
            if let window = nextResponder as? UIWindow {
                return window
            }
        }
        
        return nil
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
            navigationController?.popViewController(animated: true, completion: completion)
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: completion)
        }
    }
    
    /// Removes all presented view controllers and navigates to the root.
    public func removeToRoot(animated: Bool, completion: (() -> Swift.Void)? = nil) {
        if let rootPresentingViewController = rootPresentingViewController {
            let _navigationVc = rootPresentingViewController.navigationController ?? rootPresentingViewController as? UINavigationController
            if let navigationVc = _navigationVc {
                if animated, let window = window {
                    // Dismiss and pop animations together. Create overlay and animate it instead to prevent transition warning.
                    let imageVc = UIViewController()
                    imageVc.modalPresentationStyle = .overFullScreen
                    imageVc.view.backgroundColor = .clear
                    
                    let overlayImage = window.getSnapshotImage()
                    
                    // Place image view as window overlay first to hide controllers transitions
                    let windowOverlayImageView = UIImageView(image: overlayImage)
                    windowOverlayImageView.frame = window.bounds
                    window.addSubview(windowOverlayImageView)
                    
                    // Create controller with overlay to animate dismiss
                    let controllerOverlayImageView = UIImageView(image: overlayImage)
                    controllerOverlayImageView.frame = imageVc.view.bounds
                    imageVc.view.addSubview(controllerOverlayImageView)
                    
                    // Dismiss all view controller without animations first
                    rootPresentingViewController.dismiss(animated: false) {
                        // Pop all view controllers without animations next
                        navigationVc.popToRootViewController(animated: false) {
                            // Show overlay wihtout animations after
                            window.rootViewController?.present(imageVc, animated: false) {
                                // Remove window overlay first
                                windowOverlayImageView.removeFromSuperview()
                                
                                // Dismiss controller with overlay animated
                                imageVc.dismiss(animated: true, completion: completion)
                            }
                        }
                    }
                    
                } else {
                    if let window = window {
                        // Remove without animations but with overlay
                        let overlayImage = window.getSnapshotImage()
                        let windowOverlayImageView = UIImageView(image: overlayImage)
                        windowOverlayImageView.frame = window.bounds
                        window.addSubview(windowOverlayImageView)
                        
                        rootPresentingViewController.dismiss(animated: false) {
                            navigationVc.popToRootViewController(animated: false) {
                                windowOverlayImageView.removeFromSuperview()
                                completion?()
                            }
                        }
                    } else {
                        // Remove without animations and overlay
                        rootPresentingViewController.dismiss(animated: false) {
                            navigationVc.popToRootViewController(animated: false, completion: completion)
                        }
                    }
                }
                
            } else {
                // Just dismiss
                rootPresentingViewController.dismiss(animated: animated, completion: completion)
            }
            
        } else if let navigationVc = navigationController {
            // Just pop
            navigationVc.popToRootViewController(animated: animated, completion: completion)
        } else {
            // Nothing to do
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
