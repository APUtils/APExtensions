//
//  UIStackView+Storyboard.swift
//  Pods
//
//  Created by Anton Plebanovich on 27.09.24.
//  Copyright © 2024 Anton Plebanovich. All rights reserved.
//

#if SPM
import APExtensionsShared
#endif
import UIKit

// ******************************* MARK: - Fit Screen

private var defaultConstantAssociationKey = 0

extension UIStackView {
    private var defaultSpacing: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &defaultConstantAssociationKey) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &defaultConstantAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Scale spacing to fit screen. Assuming source font is for 2208x1242 screen.
    /// In case you need to change constant value programmatically - reset this flag to false first.
    @IBInspectable open var fitScreenSize: Bool {
        get {
            return defaultSpacing != nil
        }
        set {
            if newValue {
                // Scale if isn't yet
                guard defaultSpacing == nil else { return }
                
                defaultSpacing = spacing
                if spacing != 0 {
                    var newConstant = spacing * c.screenResizeCoef
                    newConstant = newConstant.rounded()
                    spacing = newConstant
                }
                
            } else {
                // Restore
                if let defaultSpacing = defaultSpacing {
                    spacing = defaultSpacing
                    self.defaultSpacing = nil
                }
            }
        }
    }
}
