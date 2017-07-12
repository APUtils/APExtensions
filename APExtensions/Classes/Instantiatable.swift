//
//  Instantiatable.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/19/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit

//-----------------------------------------------------------------------------
// MARK: - Instantiatable
//-----------------------------------------------------------------------------

public protocol Instantiatable {
    static func instantiate() -> Self
}

public extension Instantiatable where Self: NSObject {
    private final static func objectFromXib<T>() -> T {
        return UINib(nibName: className, bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
    
    /// Instantiates object from xib file. 
    /// Xib filename should be equal to object class name.
    public final static func instantiate() -> Self {
        return objectFromXib()
    }
}

//-----------------------------------------------------------------------------
// MARK: - InstantiatableContentView
//-----------------------------------------------------------------------------

public protocol InstantiatableContentView {
    func instantiateContentView() -> UIView
}

public extension InstantiatableContentView where Self: NSObject {
    /// Instantiates contentView from xib file and making instantiator it's owner.
    /// Xib filename should be composed of className + "ContentView" postfix. E.g. MyView -> MyViewContentView
    public final func instantiateContentView() -> UIView {
        return UINib(nibName: "\(type(of: self).className)ContentView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
}
