//
//  NSLayoutConstraint+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/12/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

#if SPM
import APExtensionsShared
#endif
import UIKit

// ******************************* MARK: - Fit Screen

private var defaultConstantAssociationKey = 0

extension NSLayoutConstraint {
    private var defaultConstant: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &defaultConstantAssociationKey) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &defaultConstantAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Scale constraint constant to fit screen. Assuming source font is for 2208x1242 screen.
    /// In case you need to change constant value programmatically - reset this flag to false first.
    @IBInspectable open var fitScreenSize: Bool {
        get {
            return defaultConstant != nil
        }
        set {
            if newValue {
                // Scale if isn't yet
                guard defaultConstant == nil else { return }
                
                defaultConstant = constant
                if constant != 0 {
                    var newConstant = constant * c.screenResizeCoef
                    newConstant = newConstant.rounded()
                    constant = newConstant
                }
                
            } else {
                // Restore
                if let defaultConstant = defaultConstant {
                    constant = defaultConstant
                    self.defaultConstant = nil
                }
            }
        }
    }
}

// ******************************* MARK: - One Pixel Width

extension NSLayoutConstraint {
    /// Make one pixel size constraint
    @IBInspectable open var onePixelSize: Bool {
        get {
            return constant == 1 / UIScreen.main.scale
        }
        set {
            constant = 1 / UIScreen.main.scale
        }
    }
}
