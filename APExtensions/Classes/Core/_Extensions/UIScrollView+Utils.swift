//
//  UIScrollView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 5/18/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Insets

public extension UIScrollView {
    /// Set value for top `contentInset` and `scrollIndicatorInsets`
    public func setTopInset(_ topInset: CGFloat) {
        contentInset.top = topInset
        scrollIndicatorInsets.top = topInset
    }
    
    /// Set 64 for top `contentInset` and `scrollIndicatorInsets`
    public func setTopNavigationBarsInset() {
        setTopInset(64)
    }
    
    /// Set value for top `contentInset` and `scrollIndicatorInsets`
    public func setBottomInset(_ bottomInset: CGFloat) {
        contentInset.bottom = bottomInset
        scrollIndicatorInsets.bottom = bottomInset
    }
    
    /// Set 49 for top `contentInset` and `scrollIndicatorInsets`
    public func setBottomTabBarInset() {
        setBottomInset(49)
    }
    
    /// Assures that contentOffset value is correct.
    public func clampContentOffset() {
        var newContentOffset = contentOffset
        newContentOffset.y = min(newContentOffset.y, contentSize.height - bounds.size.height)
        newContentOffset.y = min(newContentOffset.y, -contentInset.top)
    }
}

// ******************************* MARK: - UIRefreshControl

@available(iOS 10.0, *)
public extension UIScrollView {
    /// Adds refresh control. Call finishRefresh() to stop.
    public func addRefreshControl(target: AnyObject?, action: Selector) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    /// Stops refresh
    public func finishRefresh() {
        refreshControl?.endRefreshing()
    }
}

// ******************************* MARK: - Scroll

public extension UIScrollView {
    public func scrollToBottom(animated: Bool) {
        let height = bounds.size.height
        var y: CGFloat = 0.0
        
        if #available(iOS 11.0, *) {
            y += adjustedContentInset.bottom
        } else {
            y += contentInset.bottom
        }
        
        if contentSize.height > height {
            y += contentSize.height - height
        }
        setContentOffset(CGPoint(x: 0, y: y), animated: animated)
    }
}
