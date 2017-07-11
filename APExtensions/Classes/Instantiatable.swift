//
//  Instantiatable.swift
//  Direct Booking
//
//  Created by mac-246 on 6/19/17.
//  Copyright © 2017 Convene. All rights reserved.
//

import UIKit


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
