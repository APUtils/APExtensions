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
    static func instantiateFromXib() -> Self
}

public extension InstantiatableFromXib where Self: NSObject {
    private static func objectFromXib<T>() -> T {
        return UINib(nibName: className, bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
    
    /// Instantiates object from xib file. 
    /// Xib filename should be equal to object class name.
    static func instantiateFromXib() -> Self {
        return objectFromXib()
    }
}

// ******************************* MARK: - InstantiatableFromStoryboard

/// Helps to instantiate object from storyboard file.
public protocol InstantiatableFromStoryboard: AnyObject {
    static var storyboardName: String { get }
    static var storyboardID: String { get }
    static func instantiateFromStoryboard() -> Self
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
    static func instantiateFromStoryboard() -> Self {
        return controllerFromStoryboard()
    }
}

// ******************************* MARK: - InstantiatableContentView

/// Helps to instantiate content view from storyboard file.
public protocol InstantiatableContentView {
    func instantiateContentView() -> UIView
}

public extension InstantiatableContentView where Self: NSObject {
    
    /// Instantiates contentView from xib file and makes instantiator it's owner.
    /// Xib filename should be composed of className + "ContentView" postfix. E.g. MyView -> MyViewContentView
    func instantiateContentView() -> UIView {
        return UINib(nibName: "\(type(of: self).className)ContentView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
}

public extension InstantiatableContentView where Self: UIView {
    
    /// Instantiates contentView from xib file and makes instantiator it's owner.
    /// Xib filename should be composed of className + "ContentView" postfix. E.g. MyView -> MyViewContentView
    /// After creation puts content view as subview to self and constraints sides.
    /// Also makes self background color transparent.
    /// The main idea here is that content view should fully set how self view looks.
    /// - parameter insets: Insets to the `containerView`. `.zero` by default.
    /// - parameter bottomPriority: Bottom constraint priority. In some cases non-required priority might be preffered. 
    @available(iOS 9.0, *)
    func instantiateAndAttachContentView(insets: UIEdgeInsets = .zero, bottomPriority: UILayoutPriority = .required) {
        backgroundColor = .clear
        let contentView = instantiateContentView()
        size = contentView.bounds.inset(by: insets.reversed).size // Content bounds have priority
        contentView.center = bounds.center
        addSubview(contentView)
        contentView.constraintSides(to: self, insets: insets, bottomPriority: bottomPriority)
    }
}
