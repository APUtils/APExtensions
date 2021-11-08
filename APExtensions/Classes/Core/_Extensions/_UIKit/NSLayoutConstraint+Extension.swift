//
//  NSLayoutConstraint+Extension.swift
//  APExtensions-example
//
//  Created by Anton Plebanovich on 8.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    
    /// Activates each non-nil constraint in the specified array.
    ///
    /// This convenience method provides an easy way to activate a set of constraints with one call.
    /// The effect of this method is the same as setting the isActive property of each constraint to `true`.
    /// Typically, using this method is more efficient than activating each constraint individually.
    ///
    /// - Parameter constraints: An array of constraints to activate.
    static func activate(_ constraints: [NSLayoutConstraint?]) {
        let nonOptionalConstraints = constraints.compactMap { $0 }
        activate(nonOptionalConstraints)
    }
    
    /// Deactivates each non-nil constraint in the specified array.
    ///
    /// This convenience method provides an easy way to deactivate a set of constraints with one call.
    /// The effect of this method is the same as setting the isActive property of each constraint to `false`.
    /// Typically, using this method is more efficient than activating each constraint individually.
    ///
    /// - Parameter constraints: An array of constraints to activate.
    static func deactivate(_ constraints: [NSLayoutConstraint?]) {
        let nonOptionalConstraints = constraints.compactMap { $0 }
        deactivate(nonOptionalConstraints)
    }
    
    /// First item casted to `UIView`
    var firstView: UIView? { firstItem as? UIView }
    
    /// Second item casted to `UIView`
    var secondView: UIView? { secondItem as? UIView }
    
    /// Gets attribute for a provided view.
    /// - Parameter view: The view to get attribute for.
    /// - Returns: The attribute value for a provided view or `nil` if a view and the constraint isn't related.
    func attribute(for view: UIView) -> Attribute? {
        if firstView === view {
            return firstAttribute
        } else if secondView === view {
            return secondAttribute
        } else {
            RoutableLogger.logError("Unrelated view for a constraint", data: ["self": self, "view": view])
            return nil
        }
    }
    
    /// Gets attribute for other view that differs from provided one.
    /// - Parameter view: The view to use to determine other view.
    /// - Returns: The attribute value for other view or `nil` if a view and the constraint isn't related.
    func attributeForOtherView(view: UIView) -> Attribute? {
        guard let otherView = self.otherView(to: view) else { return nil }
        
        if firstView === otherView {
            return firstAttribute
        } else if secondView === otherView {
            return secondAttribute
        } else {
            RoutableLogger.logError("Unrelated view for a constraint", data: ["self": self, "view": view])
            return nil
        }
    }
    
    /// Properly signed constant to use in a expression `viewPosition = otherViewPosition + c`.
    /// - Parameter view: The view to use to determine constant sign.
    /// - Returns: The constant with a proper sign.
    func constant(to view: UIView) -> CGFloat? {
        if firstView === view {
            return constant
        } else if secondView === view {
            return -constant
        } else {
            RoutableLogger.logError("Unrelated view for a constraint", data: ["self": self, "view": view])
            return nil
        }
    }
    
    /// Returns other view that is related to the provided view by the constraint.
    /// - Parameter view: The view to use to determine the other view.
    /// - Returns: The other view.
    func otherView(to view: UIView) -> UIView? {
        if firstView === view {
            return secondView
        } else if secondView === view {
            return firstView
        } else {
            RoutableLogger.logError("Unrelated view for a constraint", data: ["self": self, "view": view])
            return nil
        }
    }
}
