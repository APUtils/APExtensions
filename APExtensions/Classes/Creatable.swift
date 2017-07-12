//
//  Creatable.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/12/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public protocol Creatable: class {
    static func create() -> Self
    static func createWithNavigationController() -> UINavigationController
}

public extension Creatable where Self: UIViewController {
    private final static func controllerFromStoryboard<T>() -> T {
        let storyboardName = className.replacingOccurrences(of: "ViewController", with: "")
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as! T
    }
    
    public final static func create() -> Self {
        return controllerFromStoryboard()
    }
    
    public final static func createWithNavigationController() -> UINavigationController {
        let vc = create()
        let navigationVc = UINavigationController(rootViewController: vc)
        
        return navigationVc
    }
}
