//
//  ScrollViewCustomHorizontalPageSize.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/18/18.
//  Copyright © 2018 Anton Plebanovich. All rights reserved.
//

import UIKit


/// Protocol that simplifies custom page size configuration for UIScrollView.
/// Sadly, can not be done better due to protocol extensions limitations - https://stackoverflow.com/questions/39487168/non-objc-method-does-not-satisfy-optional-requirement-of-objc-protocol
/// - note: Set `.decelerationRate` to `UIScrollViewDecelerationRateFast` for a fancy scrolling animation.
public protocol ScrollViewCustomHorizontalPageSize: UIScrollViewDelegate {
    /// Custom page size
    var pageSize: CGFloat { get }
    
    /// Helper method to get current page fraction
    func getCurrentPage(scrollView: UIScrollView) -> CGFloat
    
    /// Helper method to get targetContentOffset. Usage:
    ///
    ///     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    ///         targetContentOffset.pointee.x = getTargetContentOffset(scrollView: scrollView, velocity: velocity)
    ///     }
    func getTargetContentOffset(scrollView: UIScrollView, velocity: CGPoint) -> CGFloat
    
    /// Must be implemented. See `getTargetContentOffset` for more info.
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

public extension ScrollViewCustomHorizontalPageSize {
    func getCurrentPage(scrollView: UIScrollView) -> CGFloat {
        return (scrollView.contentOffset.x + scrollView.contentInset.left) / pageSize
    }
    
    func getTargetContentOffset(scrollView: UIScrollView, velocity: CGPoint) -> CGFloat {
        let targetX: CGFloat = scrollView.contentOffset.x + velocity.x * 60.0
        
        var targetIndex = (targetX + scrollView.contentInset.left) / pageSize
        let maxOffsetX = scrollView.contentSize.width - scrollView.bounds.width + scrollView.contentInset.right
        let maxIndex = (maxOffsetX + scrollView.contentInset.left) / pageSize
        if velocity.x > 0 {
            targetIndex = ceil(targetIndex)
        } else if velocity.x < 0 {
            targetIndex = floor(targetIndex)
        } else {
            let (maxFloorIndex, lastInterval) = modf(maxIndex)
            if targetIndex > maxFloorIndex {
                if targetIndex >= lastInterval / 2 + maxFloorIndex {
                    targetIndex = maxIndex
                } else {
                    targetIndex = maxFloorIndex
                }
            } else {
                targetIndex = round(targetIndex)
            }
        }
        
        if targetIndex < 0 {
            targetIndex = 0
        }
        
        var offsetX = targetIndex * pageSize - scrollView.contentInset.left
        offsetX = min(offsetX, maxOffsetX)
        
        return offsetX
    }
}
