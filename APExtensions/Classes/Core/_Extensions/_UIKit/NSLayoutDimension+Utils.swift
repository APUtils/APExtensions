//
//  NSLayoutDimension+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9.10.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation
import UIKit

public extension NSLayoutDimension {
    
    /// Returns a constraint that defines a constant size for the anchor’s size attribute with specified priority.
    /// - parameter c: A constant representing the size of the attribute associated with this dimension anchor.
    /// - parameter priority: The priority of the constraint.
    /// - returns: An NSLayoutConstraint object that defines a constant size for the attribute associated with this dimension anchor.
    @objc
    func constraint(equalToConstant c: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalToConstant: c)
        constraint.priority = priority
        return constraint
    }
    
    /// Returns a constraint that defines a constant size for the anchor’s size attribute with specified priority.
    /// - parameter c: A constant representing the size of the attribute associated with this dimension anchor.
    /// - parameter priority: The priority of the constraint.
    /// - returns: An NSLayoutConstraint object that defines a constant size for the attribute associated with this dimension anchor.
    @objc
    func constraint(greaterThanOrEqualToConstant c: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualToConstant: c)
        constraint.priority = priority
        return constraint
    }
}
