//
//  UIScrollView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 5/18/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

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
        if #available(iOS 13.0, *) {
            automaticallyAdjustsScrollIndicatorInsets = false
        }
        
        contentInset.top = topInset
        
        if #available(iOS 14.0, *) {
            verticalScrollIndicatorInsets.top = topInset
            horizontalScrollIndicatorInsets.top = topInset
        } else if #available(iOS 13.0, *) {
            // Scroll indicator inset behavior changed on iOS 13 and now its added to `contentInset`
        } else {
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
        if #available(iOS 13.0, *) {
            automaticallyAdjustsScrollIndicatorInsets = false
        }
        
        contentInset.bottom = bottomInset
        
        if #available(iOS 14.0, *) {
            verticalScrollIndicatorInsets.bottom = bottomInset
            horizontalScrollIndicatorInsets.bottom = bottomInset
        } else if #available(iOS 13.0, *) {
            // Scroll indicator inset behavior changed on iOS 13 and now its added to `contentInset`
        } else {
            scrollIndicatorInsets.bottom = bottomInset
        }
    }
    
    /// Set 49 for bottom `contentInset` and `scrollIndicatorInsets`
    func setBottomTabBarInset() {
        setBottomInset(49)
    }
}

// ******************************* MARK: - Scroll

public extension UIScrollView {
    
    /// Stops current scroll
    func stopScrolling() {
        setContentOffset(contentOffset, animated: false)
    }
    
    /// Scroll to top
    func scrollToTop(animated: Bool) {
        if let tableView = self as? UITableView, let firstRowIndexPath = tableView.firstRowIndexPath {
            // Since table view `contentSize` might change when cell become visible
            // we need to use `UITableView`'s methods instead.
            tableView.scrollToRow(at: firstRowIndexPath, at: .top, animated: animated)
            
        } else {
            let topContentOffset: CGPoint = .init(x: 0, y: -fullContentInsets.top)
            if animated {
                setContentOffset(topContentOffset, animated: true)
            } else {
                contentOffset = topContentOffset
            }
        }
    }
    
    /// Scroll to bottom
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
        
        if let tableView = self as? UITableView, let lastRowIndexPath = tableView.lastRowIndexPath {
            // Since table view `contentSize` might change when cell become visible
            // we need to use `UITableView`'s methods instead.
            tableView.scrollToRow(at: lastRowIndexPath, at: .bottom, animated: animated)
            
        } else {
            // Use `UIScrollView`'s methods
            let bottomContentOffset = _getBottomContentOffset()
            if animated {
                setContentOffset(bottomContentOffset, animated: true)
            } else {
                contentOffset = bottomContentOffset
            }
        }
    }
    
    /// Adjust content offset so view is at the center if possible.
    func scrollViewToCenter(_ view: UIView) {
        let centerY = view.convert(view.bounds, to: self).center.y
        contentOffset.y = centerY - (height + fullContentInsets.top - fullContentInsets.bottom) / 2
        clampContentOffset()
    }
    
    /// Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view: UIView, animated: Bool) {
        // Get the Y position of your child view
        let childFrame = view.convert(view.bounds, to: self)
        
        // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
        scrollRectToVisible(childFrame, animated: animated)
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
}

// ******************************* MARK: - Helper Properties

public extension UIScrollView {
    
    /// Frame of the content.
    var contentFrame: CGRect {
        CGRect(x: 0,
               y: 0,
               width: contentSize.width,
               height: contentSize.height)
            .roundedToPixel()
    }
    
    /// Scrollable frame. Equal to content size + fullContentInsets.
    var scrollableFrame: CGRect {
        CGRect(x: -fullContentInsets.left,
               y: -fullContentInsets.top,
               width: contentSize.width + fullContentInsets.right + fullContentInsets.left,
               height: contentSize.height + fullContentInsets.bottom + fullContentInsets.top)
            .roundedToPixel()
    }
    
    /// Visible content frame. Equal to bounds without insets.
    var visibleContentFrame: CGRect {
        CGRect(x: bounds.origin.x + fullContentInsets.left,
               y: bounds.origin.y + fullContentInsets.top,
               width: bounds.size.width - fullContentInsets.right - fullContentInsets.left,
               height: bounds.size.height - fullContentInsets.bottom - fullContentInsets.top)
            .roundedToPixel()
    }
    
    /// Returns whether scrollable frame is more than visible frame
    var isScrollable: Bool {
        return scrollableFrame.height .> visibleContentFrame.height
    }
}

// ******************************* MARK: - Paging

public extension UIScrollView {
    
    /// Current page size.
    /// - note: Currently, horizontal paging is only supported.
    var pageSize: CGFloat {
        return bounds.width
    }
    
    /// Current page value.
    /// - note: Currently, horizontal paging is only supported.
    var currentPage: Int {
        let currentPageFloat = (contentOffset.x + contentInset.left) / pageSize
        let currentPage = Int(currentPageFloat.rounded())
        return currentPage
    }
    
    /// Current number of pages.
    /// - note: Currently, horizontal paging is only supported.
    var numberOfPages: Int {
        let numberOfPagesFloat = (contentSize.width + contentInset.right + contentInset.left) / pageSize
        let numberOfPages = Int(numberOfPagesFloat.rounded())
        return numberOfPages
    }
    
    /// Returns `true` if scroll position is on the last page.
    /// Returns `false` otherwise.
    /// - note: Currently, horizontal paging is only supported.
    var isLastPage: Bool {
        currentPage >= numberOfPages - 1
    }
    
    /// Scrolls to the next page if it's available.
    /// - note: Currently, horizontal paging is only supported.
    func scrollToNextPage() {
        scrollToPage(currentPage + 1)
    }
    
    /// Scrolls to the page if it's available.
    /// - note: Currently, horizontal paging is only supported.
    func scrollToPage(_ page: Int) {
        let page = min(page, numberOfPages - 1)
        let contentOffsetX = page.asCGFloat * pageSize
        contentOffset.x = contentOffsetX + contentInset.left
    }
}
