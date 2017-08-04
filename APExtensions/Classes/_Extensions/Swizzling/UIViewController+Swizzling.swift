//
//  UIViewController+Swizzling.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 5/19/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


private var associatedStateKey = 0


public extension Notification.Name {
    static let UIViewControllerViewDidLoad = Notification.Name("UIViewControllerViewDidLoad")
    static let UIViewControllerViewWillAppear = Notification.Name("UIViewControllerViewWillAppear")
    static let UIViewControllerViewDidAppear = Notification.Name("UIViewControllerViewDidAppear")
    static let UIViewControllerViewWillDisappear = Notification.Name("UIViewControllerViewWillDisappear")
    static let UIViewControllerViewDidDisappear = Notification.Name("UIViewControllerViewDidDisappear")
}

extension UIViewController: SetupOnce {
    public static var setupOnce: Int = {
        g_swizzleMethods(class: UIViewController.self, originalSelector: #selector(viewDidLoad), swizzledSelector: #selector(swizzled_viewDidLoad))
        g_swizzleMethods(class: UIViewController.self, originalSelector: #selector(viewWillAppear(_:)), swizzledSelector: #selector(swizzled_viewWillAppear(_:)))
        g_swizzleMethods(class: UIViewController.self, originalSelector: #selector(viewDidAppear(_:)), swizzledSelector: #selector(swizzled_viewDidAppear(_:)))
        g_swizzleMethods(class: UIViewController.self, originalSelector: #selector(viewWillDisappear(_:)), swizzledSelector: #selector(swizzled_viewWillDisappear(_:)))
        g_swizzleMethods(class: UIViewController.self, originalSelector: #selector(viewDidDisappear(_:)), swizzledSelector: #selector(swizzled_viewDidDisappear(_:)))
        
        return 0
    }()
}

extension UIViewController {
    public enum ViewState {
        case notLoaded
        case didLoad
        case willAppear
        case didAppear
        case willDisappear
        case didDisappear
    }
    
    /// UIViewController view state
    public var viewState: ViewState {
        get {
            if let state = objc_getAssociatedObject(self, &associatedStateKey) as? ViewState {
                return state
            } else {
                objc_setAssociatedObject(self, &associatedStateKey, ViewState.notLoaded, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return ViewState.notLoaded
            }
        }
        set {
            objc_setAssociatedObject(self, &associatedStateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc fileprivate func swizzled_viewDidLoad() {
        viewState = .didLoad
        NotificationCenter.default.post(name: .UIViewControllerViewDidLoad, object: self)
        
        self.swizzled_viewDidLoad()
    }
    
    @objc fileprivate func swizzled_viewWillAppear(_ animated: Bool) {
        viewState = .willAppear
        NotificationCenter.default.post(name: .UIViewControllerViewWillAppear, object: self)
        
        self.swizzled_viewWillAppear(animated)
    }
    
    @objc fileprivate func swizzled_viewDidAppear(_ animated: Bool) {
        viewState = .didAppear
        NotificationCenter.default.post(name: .UIViewControllerViewDidAppear, object: self)
        
        self.swizzled_viewDidAppear(animated)
    }
    
    @objc fileprivate func swizzled_viewWillDisappear(_ animated: Bool) {
        viewState = .willDisappear
        NotificationCenter.default.post(name: .UIViewControllerViewWillDisappear, object: self)
        
        self.swizzled_viewWillDisappear(animated)
    }
    
    @objc fileprivate func swizzled_viewDidDisappear(_ animated: Bool) {
        viewState = .didDisappear
        NotificationCenter.default.post(name: .UIViewControllerViewDidDisappear, object: self)
        
        self.swizzled_viewDidDisappear(animated)
    }
}
