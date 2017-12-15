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
}

// ******************************* MARK: - Editing

public extension UIViewController {
    /// End editing in viewController's view
    @IBAction func endEditing(_ sender: Any) {
        view.endEditing(true)
    }
}
