//
//  NSLayoutAnchor+Utils.swift
//  Pods
//
//  Created by Anton Plebanovich on 9.10.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension NSLayoutAnchor {
    
    /// Returns a constraint that defines one item’s attribute as equal to another with specified priority.
    /// - parameter anchor: A layout anchor from a UIView, NSView, or UILayoutGuide object. You must use a subclass of NSLayoutAnchor that matches the current anchor. For example, if you call this method on an NSLayoutXAxisAnchor object, this parameter must be another NSLayoutXAxisAnchor.
    /// - parameter c: A constant representing the size of the attribute associated with this dimension anchor.
    /// - parameter priority: The priority of the constraint.
    /// - returns: An NSLayoutConstraint object that defines an equal relationship between the attributes represented by the two layout anchors.
    @objc
    func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, priority: UILayoutPriority, constant c: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: c)
        constraint.priority = priority
        return constraint
    }
    
    /// Returns a constraint that defines one item’s attribute as less than or equal to another with specified priority.
    /// - parameter anchor: A layout anchor from a UIView, NSView, or UILayoutGuide object. You must use a subclass of NSLayoutAnchor that matches the current anchor. For example, if you call this method on an NSLayoutXAxisAnchor object, this parameter must be another NSLayoutXAxisAnchor.
    /// - parameter c: A constant representing the size of the attribute associated with this dimension anchor.
    /// - parameter priority: The priority of the constraint.
    /// - returns: An NSLayoutConstraint object that defines an equal relationship between the attributes represented by the two layout anchors.
    @objc
    func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, priority: UILayoutPriority, constant c: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor)
        constraint.priority = priority
        return constraint
    }
}
