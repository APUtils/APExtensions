//
//  UIView+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 19.02.16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Border

extension UIView {
    @IBInspectable open var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return nil }
            
            return UIColor(cgColor: borderColor)
        }
        set {
            // For some reason, it may resolve to wrong color mode by default so using `applicationResolvedColor`
            layer.borderColor = newValue?._applicationResolvedColor(view: self).cgColor
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Sets border width equal to 1 pixel
    @IBInspectable open var borderOnePixelWidth: Bool {
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

extension UIView {
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if layer.cornerRadius == newValue { return }
            layer.cornerRadius = newValue
        }
    }
}

// ******************************* MARK: - Shadow

extension UIView {
    @IBInspectable open var shadowColor: UIColor? {
        get {
            guard let shadowColor = layer.shadowColor else { return nil }
            
            return UIColor(cgColor: shadowColor)
        }
        set {
            // For some reason, it may resolve to wrong color mode by default so using `applicationResolvedColor`
            layer.shadowColor = newValue?._applicationResolvedColor(view: self).cgColor
        }
    }
    
    @IBInspectable open var shadowOffset: CGPoint {
        get {
            return CGPoint(x: layer.shadowOffset.width, y: layer.shadowOffset.height)
        }
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
    }
    
    @IBInspectable open var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            // Apple: The value in this property must be in the range 0.0 (transparent) to 1.0 (opaque)
            layer.shadowOpacity = max(0, min(1, newValue))
        }
    }
    
    @IBInspectable open var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// Apply square path for shadow. This increases performance for shadow drawing in case shadow is square.
    @IBInspectable open var shadowApplyPath: Bool {
        get {
            return layer.shadowPath != nil
        }
        set {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }
}
