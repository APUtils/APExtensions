//
//  UIScrollView+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 5/18/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Helper Extension

private extension UIView {
    var _viewController: UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        
        return nil
    }
}

// ******************************* MARK: - Adjustment Behavior

@available(iOS 11.0, *)
public extension UIScrollView {
    @IBInspectable var disableAutomaticContentAdjustment: Bool {
        get {
            return contentInsetAdjustmentBehavior == .never
        }
        set {
            contentInsetAdjustmentBehavior = newValue ? .never : .automatic
        }
    }
}

// ******************************* MARK: - Bars Avoid

private let _statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
private let _navigationBarHeight: CGFloat = 44
private let _topBarsHeight: CGFloat = _statusBarHeight + _navigationBarHeight

public extension UIScrollView {
    /// Sets (status bar + 44) or 0 for top content inset and disables automatic mechanisms to prevent conflict.
    /// Returns true if scroll view avoids top bars. Takes into account `contentInsetAdjustmentBehavior`.
    @IBInspectable var avoidNavigationBar: Bool {
        get {
            if #available(iOS 11.0, *) {
                switch contentInsetAdjustmentBehavior {
                case .always: return adjustedContentInset.top == _topBarsHeight
                case .never: return contentInset.top == _topBarsHeight
                    
                case .scrollableAxes:
                    if isScrollEnabled || alwaysBounceVertical {
                        return adjustedContentInset.top == _topBarsHeight
                    } else {
                        return contentInset.top == _topBarsHeight
                    }
                
                case .automatic:
                    if let _ = _viewController?.navigationController {
                        return adjustedContentInset.top == _topBarsHeight
                    } else {
                        return contentInset.top == _topBarsHeight
                    }
                @unknown default: return false
                }
            } else {
                return contentInset.top == _topBarsHeight
            }
        }
        set {
            if #available(iOS 11.0, *) {
                disableAutomaticContentAdjustment = true
            }
            
            _viewController?.automaticallyAdjustsScrollViewInsets = false
            contentInset.top = newValue ? _topBarsHeight : 0
            
            // Scroll indicator inset behavior changed on iOS 13 and now its added to `contentInset`
            if #available(iOS 13.0, *) {} else {
                scrollIndicatorInsets.top = newValue ? _topBarsHeight : 0
            }
        }
    }
    
    /// Sets 49 or 0 for bottom inset and disables automatic mechanisms to prevent conflict.
    /// Returns true if scroll view avoids bottom bars. Takes into account `contentInsetAdjustmentBehavior`.
    @IBInspectable var avoidTabBar: Bool {
        get {
            if #available(iOS 11.0, *) {
                switch contentInsetAdjustmentBehavior {
                case .always: return adjustedContentInset.bottom == 49
                case .never: return contentInset.bottom == 49
                    
                case .scrollableAxes:
                    if isScrollEnabled || alwaysBounceVertical {
                        return adjustedContentInset.bottom == 49
                    } else {
                        return contentInset.bottom == 49
                    }
                    
                case .automatic:
                    if let _ = _viewController?.tabBarController {
                        return adjustedContentInset.bottom == 49
                    } else {
                        return contentInset.bottom == 49
                    }
                    
                @unknown default: return false
                }
            } else {
                return contentInset.bottom == 49
            }
        }
        set {
            if #available(iOS 11.0, *) {
                disableAutomaticContentAdjustment = true
            }
            
            _viewController?.automaticallyAdjustsScrollViewInsets = false
            contentInset.bottom = newValue ? 49 : 0
            
            // Scroll indicator inset behavior changed on iOS 13 and now its added to `contentInset`
            if #available(iOS 13.0, *) {} else {
                scrollIndicatorInsets.bottom = newValue ? 49 : 0
            }
        }
    }
}
