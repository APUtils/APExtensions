//
//  UIView+ViewState.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/22/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit

//-----------------------------------------------------------------------------
// MARK: - Responder Helpers
//-----------------------------------------------------------------------------

public extension UIView {
    private var _viewController: UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        
        return nil
    }
    
    /// Tells view to become first responder only after view did appear.
    ///
    /// Quote from Apple doc: "Never call this method on a view that is not part of an active view hierarchy. You can determine whether the view is onscreen, by checking its window property. If that property contains a valid window, it is part of an active view hierarchy. If that property is nil, the view is not part of a valid view hierarchy."
    ///
    /// Because configuration usually is made in `viewDidLoad` or `viewWillAppear` while `view` still might have `nil` `window` it's useful to delay `becomeFirstResponder` calls.
    public func becomeFirstResponderOnViewDidAppear() {
        guard let viewController = _viewController else { return }
        
        guard viewController.viewState != .didAppear else {
            // Already appeared
            becomeFirstResponder()
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(onViewDidAppear(notification:)), name: .UIViewControllerViewDidAppear, object: viewController)
    }
    
    @objc private func onViewDidAppear(notification: Notification) {
        NotificationCenter.default.removeObserver(self, name: .UIViewControllerViewDidAppear, object: _viewController)
        
        becomeFirstResponder()
    }
}
