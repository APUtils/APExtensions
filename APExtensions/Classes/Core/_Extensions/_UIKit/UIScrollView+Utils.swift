//
//  UIScrollView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 5/18/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Insets

public extension UIScrollView {
    
    /// Returns `adjustedContentInset` on iOS >= 11 and `contentInset` on iOS < 11.
    var fullContentInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return adjustedContentInset
        } else {
            return contentInset
        }
    }
    
    /// Set value for top `contentInset` and `scrollIndicatorInsets`
    func setTopInset(_ topInset: CGFloat) {
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        
        contentInset.top = topInset
        
        // Scroll indicator inset behavior changed on iOS 13 and now its added to `contentInset`
        if #available(iOS 13.0, *) {} else {
            scrollIndicatorInsets.top = topInset
        }
    }
    
    /// Set 64 for top `contentInset` and `scrollIndicatorInsets`
    func setTopNavigationBarsInset() {
        setTopInset(64)
    }
    
    /// Set value for bottom `contentInset` and `scrollIndicatorInsets`
    func setBottomInset(_ bottomInset: CGFloat) {
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        
        contentInset.bottom = bottomInset
        
        // Scroll indicator inset behavior changed on iOS 13 and now its added to `contentInset`
        if #available(iOS 13.0, *) {} else {
            scrollIndicatorInsets.bottom = bottomInset
        }
    }
    
    /// Set 49 for bottom `contentInset` and `scrollIndicatorInsets`
    func setBottomTabBarInset() {
        setBottomInset(49)
    }
    
    /// Assures that contentOffset value is correct.
    func clampContentOffset() {
        let minOffsetY = -fullContentInsets.top
        let maxOffsetY = max(contentSize.height - bounds.size.height + fullContentInsets.bottom, -fullContentInsets.top)
        let minOffsetX = -fullContentInsets.left
        let maxOffsetX = max(contentSize.width - bounds.size.width + fullContentInsets.right, fullContentInsets.left)
        
        var newContentOffset = contentOffset
        newContentOffset.y = min(newContentOffset.y, maxOffsetY)
        newContentOffset.y = max(newContentOffset.y, minOffsetY)
        newContentOffset.x = min(newContentOffset.x, maxOffsetX)
        newContentOffset.x = max(newContentOffset.x, minOffsetX)
        
        contentOffset = newContentOffset
    }
    
    /// Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view: UIView, animated: Bool) {
        // Get the Y position of your child view
        let childFrame = view.convert(view.bounds, to: self)
        
        // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
        scrollRectToVisible(childFrame, animated: animated)
    }
}

// ******************************* MARK: - UIRefreshControl

private var c_refreshActionAssociationKey = 0

@available(iOS 10.0, *)
public extension UIRefreshControl {
    /// Closure for refresh action.
    /// Takes `UIRefreshControl` that triggered refresh as argument.
    typealias Action = (UIRefreshControl) -> Void
    
    fileprivate var action: Action? {
        get {
            return objc_getAssociatedObject(self, &c_refreshActionAssociationKey) as? Action
        }
        set {
            objc_setAssociatedObject(self, &c_refreshActionAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc fileprivate func onRefresh(_ sender: UIRefreshControl) {
        action?(self)
    }
}

@available(iOS 10.0, *)
public extension UIScrollView {
    /// Adds refresh control. Call finishRefresh() to stop.
    func addRefreshControl(action: @escaping UIRefreshControl.Action) {
        let refreshControl = UIRefreshControl()
        refreshControl.action = action
        refreshControl.addTarget(refreshControl, action: #selector(UIRefreshControl.onRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    /// Adds refresh control. Call finishRefresh() to stop.
    func addRefreshControl(target: AnyObject?, action: Selector) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    /// Stops refresh
    func finishRefresh() {
        refreshControl?.endRefreshing()
    }
}

// ******************************* MARK: - Scroll

public extension UIScrollView {
    func scrollToTop(animated: Bool) {
        func _scrollToTop(animated: Bool) {
            let topContentOffset: CGPoint = .init(x: 0, y: -fullContentInsets.top)
            if animated {
                setContentOffset(topContentOffset, animated: true)
            } else {
                contentOffset = topContentOffset
            }
        }
        
        _scrollToTop(animated: animated)
    }
    
    func scrollToBottom(animated: Bool) {
        func _getBottomContentOffset() -> CGPoint {
            let height = bounds.size.height
            var y: CGFloat = fullContentInsets.bottom
            if contentSize.height > height {
                y += contentSize.height - height
            }
            
            let minOffsetY = -fullContentInsets.top
            let maxOffsetY = max(contentSize.height - bounds.size.height + fullContentInsets.bottom, -fullContentInsets.top)
            y = min(y, maxOffsetY)
            y = max(y, minOffsetY)
            
            return CGPoint(x: 0, y: y)
        }
        
        func _scrollToBottom(animated: Bool) {
            let bottomContentOffset = _getBottomContentOffset()
            
            if let tableView = self as? UITableView {
                // Since table view `contentSize` might change when cell become visible
                // we need to use `UITableView`'s methods instead.
                let lastSection = tableView.numberOfSections - 1
                let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
                let lastRowIndexPath = IndexPath(row: lastRow, section: lastSection)
                tableView.scrollToRow(at: lastRowIndexPath, at: .bottom, animated: animated)
                
            } else {
                // Use `UIScrollView`'s methods
                if animated {
                    setContentOffset(bottomContentOffset, animated: true)
                } else {
                    contentOffset = bottomContentOffset
                }
            }
        }
        
        _scrollToBottom(animated: animated)
    }
}
