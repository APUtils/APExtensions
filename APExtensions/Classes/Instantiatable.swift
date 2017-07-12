//
//  Instantiatable.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/19/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public protocol Instantiatable {
    static func instantiate() -> Self
    static func instantiate(owner: Any) -> Self
}

public extension Instantiatable where Self: NSObject {
    private final static func objectFromXib<T>(owner: Any?) -> T {
        return UINib(nibName: className, bundle: nil).instantiate(withOwner: owner, options: nil).first as! T
    }
    
    /// Instantiates object from xib file. 
    /// Xib filename should be equal to object class name.
    public final static func instantiate() -> Self {
        return objectFromXib(owner: nil)
    }
    
    /// Instantiates object from xib file with specified owner.
    /// Xib filename should be equal to object class name.
    public final static func instantiate(owner: Any) -> Self {
        return objectFromXib(owner: owner)
    }
}
