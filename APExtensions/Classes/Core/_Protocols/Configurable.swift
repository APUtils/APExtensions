//
//  Configurable.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/16/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import Foundation


public protocol Configurable {
    /// Usually cells might conform to this protocol so we just can pass view model without typecasting.
    func configure(model: Any)
}


// TODO: Remove in Swift 4 because it'll be possible to use types like UITableView & Configurable
extension UITableViewCell: Configurable {
    public func configure(model: Any) {
        assertionFailure("Method must be overriden in subclass")
    }
}
