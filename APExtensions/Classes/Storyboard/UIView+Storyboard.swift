//
//  UIView+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 19.02.16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Border

public extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return nil }
            
            return UIColor(cgColor: borderColor)
        }
        set {
            // For some reason, it may resolve to wrong color mode by default so using `resolvedColor`
            if #available(iOS 13.0, *) {
                layer.borderColor = newValue?.resolvedColor(with: traitCollection).cgColor
            } else {
                layer.borderColor = newValue?.cgColor
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Sets border width equal to 1 pixel
    @IBInspectable var borderOnePixelWidth: Bool {
        get {
            return layer.borderWidth == 1.0 / UIScreen.main.scale
        }
        set {
            if newValue {
                layer.borderWidth = 1.0 / UIScreen.main.scale
            } else {
                layer.borderWidth = 1.0
            }
        }
    }
}

// ******************************* MARK: - Corner Radius

public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

// ******************************* MARK: - Shadow

public extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let shadowColor = layer.shadowColor else { return nil }
            
            return UIColor(cgColor: shadowColor)
        }
        set {
            // For some reason, it may resolve to wrong color mode by default so using `resolvedColor`
            if #available(iOS 13.0, *) {
                layer.shadowColor = newValue?.resolvedColor(with: traitCollection).cgColor
            } else {
                layer.shadowColor = newValue?.cgColor
            }
        }
    }
    
    @IBInspectable var shadowOffset: CGPoint {
        get {
            return CGPoint(x: layer.shadowOffset.width, y: layer.shadowOffset.height)
        }
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            // Apple: The value in this property must be in the range 0.0 (transparent) to 1.0 (opaque)
            layer.shadowOpacity = max(0, min(1, newValue))
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// Apply square path for shadow. This increases performance for shadow drawing in case shadow is square.
    @IBInspectable var shadowApplyPath: Bool {
        get {
            return layer.shadowPath != nil
        }
        set {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }
}
