//
//  UIResponder+ViewState.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/19/18.
//  Copyright © 2018 Anton Plebanovich. All rights reserved.
//

import UIKit


private var c_becomeFirstResponderWhenPossibleAssociationKey = 0
private var c_becomeFirstResponderOnViewDidAppearAssociationKey = 0

public extension UIResponder {
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
    
    private var _becomeFirstResponderWhenPossible: Bool {
        get {
            return objc_getAssociatedObject(self, &c_becomeFirstResponderWhenPossibleAssociationKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &c_becomeFirstResponderWhenPossibleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var _becomeFirstResponderOnViewDidAppear: Bool {
        get {
            return objc_getAssociatedObject(self, &c_becomeFirstResponderOnViewDidAppearAssociationKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &c_becomeFirstResponderOnViewDidAppearAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Tells responder to become first when view has window.
    ///
    /// Quote from Apple doc: "Never call this method on a view that is not part of an active view hierarchy. You can determine whether the view is onscreen, by checking its window property. If that property contains a valid window, it is part of an active view hierarchy. If that property is nil, the view is not part of a valid view hierarchy."
    ///
    /// Because configuration usually is made in `viewDidLoad` or `viewWillAppear` while `view` still might have `nil` `window` it's useful to delay `becomeFirstResponder` calls.
    @IBInspectable public var becomeFirstResponderWhenPossible: Bool {
        get {
            return _becomeFirstResponderWhenPossible
        }
        set {
            guard newValue != _becomeFirstResponderWhenPossible else { return }
            
            _becomeFirstResponderWhenPossible = newValue
            
            if newValue {
                let vc = _viewController
                if vc?.viewState == .didAttach || vc?.viewState == .didAppear {
                    // Already appeared
                    self._becomeFirstResponderWhenPossible = false
                    self.becomeFirstResponder()
                } else {
                    // Wait until appeared
                    var stateDidChangedToken: NSObjectProtocol! = nil
                    let handleNotification: (Notification) -> Void = { [weak self] notification in
                        guard let `self` = self, self._becomeFirstResponderWhenPossible else {
                            // Object no longer exists or no longer notification no longer needed.
                            // Remove observer.
                            NotificationCenter.default.removeObserver(stateDidChangedToken)
                            return
                        }
                        guard self._viewController == notification.object as? UIViewController else { return }
                        guard self._viewController?.isViewLoaded == true && self._viewController?.view.window != nil else { return }
                        
                        // Got our notification. Remove observer.
                        NotificationCenter.default.removeObserver(stateDidChangedToken)
                        
                        // Reset this flag so we can assign it again later if needed
                        self._becomeFirstResponderWhenPossible = false
                        
                        self.becomeFirstResponder()
                    }
                    stateDidChangedToken = NotificationCenter.default.addObserver(forName: .UIViewControllerViewStateDidChange, object: vc, queue: nil, using: handleNotification)
                }
            } else {
                
            }
        }
    }
    
    /// Tells responder to become first only after view did appear.
    ///
    /// Quote from Apple doc: "Never call this method on a view that is not part of an active view hierarchy. You can determine whether the view is onscreen, by checking its window property. If that property contains a valid window, it is part of an active view hierarchy. If that property is nil, the view is not part of a valid view hierarchy."
    ///
    /// Because configuration usually is made in `viewDidLoad` or `viewWillAppear` while `view` still might have `nil` `window` it's useful to delay `becomeFirstResponder` calls.
    @IBInspectable public var becomeFirstResponderOnViewDidAppear: Bool {
        get {
            return _becomeFirstResponderOnViewDidAppear
        }
        set {
            guard newValue != becomeFirstResponderOnViewDidAppear else { return }
            
            _becomeFirstResponderOnViewDidAppear = newValue
            
            if newValue {
                let vc = _viewController
                if vc?.viewState == .didAppear {
                    // Already appeared
                    self._becomeFirstResponderOnViewDidAppear = false
                    self.becomeFirstResponder()
                } else {
                    // Wait until appeared
                    var token: NSObjectProtocol!
                    token = NotificationCenter.default.addObserver(forName: .UIViewControllerViewDidAppear, object: vc, queue: nil) { [weak self] notification in
                        guard let `self` = self, self._becomeFirstResponderOnViewDidAppear else {
                            // Object no longer exists or no longer notification no longer needed.
                            // Remove observer.
                            NotificationCenter.default.removeObserver(token)
                            return
                        }
                        guard self._viewController == notification.object as? UIViewController else { return }
                        
                        // Got our notification. Remove observer.
                        NotificationCenter.default.removeObserver(token)
                        
                        // Reset this flag so we can assign it again later if needed
                        self._becomeFirstResponderOnViewDidAppear = false
                        self.becomeFirstResponder()
                    }
                }
            } else {
                
            }
        }
    }
}
