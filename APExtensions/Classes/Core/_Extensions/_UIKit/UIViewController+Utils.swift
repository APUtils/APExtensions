//
//  UIViewController+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 28/05/16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Navigation

private class ImageOverlayViewController: UIViewController {
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        window?.isHidden = true
    }
}

private extension UIWindow {
    /// Creates and shows overlay window with image of hoster window.
    /// Call passed dismiss closure with animation param in operationsCompletion when it's time to dismiss it.
    func performUnderOverlay(operationsCompletion: @escaping (_ dismiss: @escaping (_ animated: Bool) -> Void) -> Void, completion: SimpleClosure?) {
        let window = UIWindow.createNormal()
       
        let imageVC = ImageOverlayViewController()
        imageVC.modalPresentationStyle = .overFullScreen
        imageVC.view.backgroundColor = .clear
        
        let overlayImage = getSnapshotImage()
        
        // Create controller with overlay to animate dismiss
        let controllerOverlayImageView = UIImageView(image: overlayImage)
        controllerOverlayImageView.frame = imageVC.view.bounds
        controllerOverlayImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageVC.view.addSubview(controllerOverlayImageView)
        
        window.makeKeyAndVisible()
        window.rootViewController?.present(imageVC, animated: false) {
            operationsCompletion { animated in
                imageVC.dismiss(animated: animated) {
                    completion?()
                    
                    // Capture window till the end
                    _ = window
                }
            }
        }
    }
}

public extension UIViewController {
    /// Previous view controller in navigation stack
    var previous: UIViewController? {
        guard let navigationVcs = navigationController?.viewControllers, let currentVcIndex = navigationVcs.firstIndex(of: self) else { return nil }
        
        let previousIndex = currentVcIndex - 1
        if previousIndex >= 0 {
            return navigationVcs[previousIndex]
        } else {
            return nil
        }
    }
    
    /// Goes down presentation chain and returns root view controller that presents whole chain.
    var rootPresentingViewController: UIViewController? {
        var rootPresentingViewController = presentingViewController
        while let presentingVc = rootPresentingViewController?.presentingViewController {
            rootPresentingViewController = presentingVc
        }
        
        return rootPresentingViewController
    }
    
    /// Try to get window that owns this view controller.
    var window: UIWindow? {
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
    
    /// Returns true if controller curently is pushing, presenting, poping or dismissing.
    var isBeingTransitioned: Bool {
        return isBeingAdded || isBeingRemoved
    }
    
    /// Returns true if controller curently is pushing or presenting.
    var isBeingAdded: Bool {
        return isMovingToParent
            || isBeingPresented
            || (navigationController?.isMovingToParent ?? false)
            || (navigationController?.isBeingPresented ?? false)
    }
    
    /// Returns true if controller curently is poping or dismissing.
    var isBeingRemoved: Bool {
        return isMovingFromParent
            || isBeingDismissed
            || (navigationController?.isMovingFromParent ?? false)
            || (navigationController?.isBeingDismissed ?? false)
    }
    
    /// Presents view controller animated
    func present(_ vc: UIViewController) {
        present(vc, animated: true)
    }
}

// ******************************* MARK: - Remove
    
extension UIViewController {
    
    /// Remove view controller animated action. Removes using pop if it was pushed or using dismiss if it was presented.
    @IBAction open func remove(sender: Any) {
        remove(animated: true)
    }
    
    /// Removes view controller using pop if it was pushed or using dismiss if it was presented.
    /// Removes also overlaying controllers if needed.
    public func remove(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        if let navigationController = navigationController {
            // Has navigation controller
            if navigationController.presentedViewController != nil {
                // Has overlaying presented controllers
                let viewControllers = navigationController.viewControllers
                
                if viewControllers.first == self {
                    // First controller in navigation stack.
                    // Dismiss together with navigation controller or just dismiss overlaying controllers if navigation can not be dismissed (e.g. it root).
                    navigationController.presentingViewController?.dismiss(animated: animated, completion: completion)
                    
                } else {
                    // Has underlaying controller(s) in stack. Dismiss all overlaying controllers and pop.
                    if let window = window {
                        // Has window. Remove with overlay.
                        window.performUnderOverlay(operationsCompletion: { dismiss in
                            navigationController.dismiss(animated: false) {
                                navigationController.pop(viewController: self, animated: false) {
                                    dismiss(animated)
                                }
                            }
                        }, completion: completion)
                        
                    } else {
                        // No window. Remove without animations and overlay.
                        navigationController.dismiss(animated: false) {
                            navigationController.pop(viewController: self, animated: false, completion: completion)
                        }
                    }
                }
                
            } else {
                // No overlaying presented controllers.
                let viewControllers = navigationController.viewControllers
                
                if viewControllers.first == self {
                    // First controller in navigation stack.
                    if let presentingViewController = navigationController.presentingViewController {
                        // Has presentingViewController. Dismiss together with navigation controller.
                        presentingViewController.dismiss(animated: animated, completion: completion)
                    } else {
                        // No presentingViewController. Just pop overlaying controllers.
                        navigationController.popToRootViewController(animated: animated, completion: completion)
                    }
                } else {
                    // Has underlaying controller(s) in stack. Pop it with overlaying controllers.
                    navigationController.pop(viewController: self, animated: animated, completion: completion)
                }
            }
            
        } else if presentingViewController != nil {
            // Not in navigation stack but was presented. Dismiss.
            dismiss(animated: animated, completion: completion)
            
        } else {
            // Unknown container or root. Can not do anything.
            completion?()
        }
    }
    
    /// Removes all presented view controllers and navigates to the root.
    public func removeToRoot(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        if let rootPresentingViewController = rootPresentingViewController {
            
            let _navigationVc = rootPresentingViewController.navigationController ?? rootPresentingViewController as? UINavigationController
            if let navigationVc = _navigationVc {
                
                if let window = window {
                    // Dismiss and pop animations together. Create overlay and animate it instead to prevent transition warning.
                    window.performUnderOverlay(operationsCompletion: { dismiss in
                        // Dismiss all view controller without animations first
                        rootPresentingViewController.dismiss(animated: false) {
                            // Pop all view controllers without animations next
                            navigationVc.popToRootViewController(animated: false) {
                                dismiss(animated)
                            }
                        }
                    }, completion: completion)

                } else {
                    // Remove without animations and overlay
                    rootPresentingViewController.dismiss(animated: false) {
                        navigationVc.popToRootViewController(animated: false, completion: completion)
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

extension UIViewController {
    
    /// End editing in viewController's view
    @IBAction open func endEditing(_ sender: Any) {
        view.endEditing(true)
    }
}

// ******************************* MARK: - Other

public extension UIViewController {
    
    /// Returns navigation controller with self as root.
    var wrappedIntoNavigation: UINavigationController {
        let vc = UINavigationController(rootViewController: self)
        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }
}
