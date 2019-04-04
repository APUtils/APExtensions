//
//  Instantiatable.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/19/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - InstantiatableFromXib

/// Helps to instantiate object from xib file.
public protocol InstantiatableFromXib {
    static func create() -> Self
}

public extension InstantiatableFromXib where Self: NSObject {
    private static func objectFromXib<T>() -> T {
        return UINib(nibName: className, bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
    
    /// Instantiates object from xib file. 
    /// Xib filename should be equal to object class name.
    static func create() -> Self {
        return objectFromXib()
    }
}

// ******************************* MARK: - InstantiatableFromStoryboard

/// Helps to instantiate object from storyboard file.
public protocol InstantiatableFromStoryboard: class {
    static var storyboardName: String { get }
    static var storyboardID: String { get }
    static func create() -> Self
    static func createWithNavigationController() -> (UINavigationController, Self)
}

public extension InstantiatableFromStoryboard where Self: UIViewController {
    private static func controllerFromStoryboard<T>() -> T {
        let storyboardName = self.storyboardName
        if let initialVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as? T {
            return initialVc
        } else {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: className) as! T
        }
    }
    
    /// Name of storyboard that contains this view controller.
    /// If not specified uses view controller's class name without "ViewController" or "VC" postfix.
    static var storyboardName: String {
        if className.hasSuffix("ViewController") {
            return className.replacingOccurrences(of: "ViewController", with: "")
        } else if className.hasSuffix("VC") {
            return className.replacingOccurrences(of: "VC", with: "")
        } else {
            fatalError("Please specify proper `storyboardName` for your view controller")
        }
    }
    
    /// View controller storyboard ID.
    /// By default uses view controller's class name.
    static var storyboardID: String {
        return className
    }
    
    /// Instantiates view controller from storyboard file.
    /// By default uses view controller's class name without "ViewController" postfix for `storyboardName` and view controller's class name for `storyboardID`.
    /// Implement `storyboardName` if you want to secify custom storyboard name.
    /// Implement `storyboardID` if you want to specify custom storyboard ID.
    static func create() -> Self {
        return controllerFromStoryboard()
    }
    
    /// Instantiates view controller from storyboard file wrapped into navigation controller.
    /// By default uses view controller's class name without "ViewController" postfix for `storyboardName` and view controller's class name for `storyboardID`.
    /// Implement `storyboardName` if you want to secify custom storyboard name.
    /// Implement `storyboardID` if you want to specify custom storyboard ID.
    static func createWithNavigationController() -> (UINavigationController, Self) {
        let vc = create()
        let navigationVc = UINavigationController(rootViewController: vc)
        
        return (navigationVc, vc)
    }
}

// ******************************* MARK: - InstantiatableContentView

/// Helps to instantiate content view from storyboard file.
public protocol InstantiatableContentView {
    func createContentView() -> UIView
}

public extension InstantiatableContentView where Self: NSObject {
    /// Instantiates contentView from xib file and makes instantiator it's owner.
    /// Xib filename should be composed of className + "ContentView" postfix. E.g. MyView -> MyViewContentView
    func createContentView() -> UIView {
        return UINib(nibName: "\(type(of: self).className)ContentView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
}

public extension InstantiatableContentView where Self: UIView {
    /// Instantiates contentView from xib file and makes instantiator it's owner.
    /// Xib filename should be composed of className + "ContentView" postfix. E.g. MyView -> MyViewContentView
    /// After creation puts content view as subview to self and constraints sides.
    /// Also makes self background color transparent.
    /// The main idea here is that content view should fully set how self view looks.
    @available(iOS 9.0, *)
    func createAndAttachContentView() {
        backgroundColor = .clear
        let contentView = createContentView()
        contentView.frame = bounds
        addSubview(contentView)
        contentView.constraintSides(to: self)
    }
}
