//
//  UITableView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/23/16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Other

public extension UITableView {
    
    /// Returns first section's first row index path.
    /// If table view has zero sections returns `nil`.
    /// If table view has zero cells for the first section returns (0, NSNotFound)
    /// and this index path is valid for scrolling.
    var firstRowIndexPath: IndexPath? {
        let firstSection: Int = (min(0, numberOfSections - 1))._clampedRowOrSection
        if firstSection == NSNotFound {
            return nil
        }
        
        let firstRow = (min(0, numberOfRows(inSection: firstSection) - 1))._clampedRowOrSection
        let firstRowIndexPath = IndexPath(row: firstRow, section: firstSection)
        
        return firstRowIndexPath
    }
    
    /// Returns last row index path or NSNotFound
    /// If table view has zero sections returns `nil`.
    /// If table view has zero cells for the last section returns (section, NSNotFound)
    /// and this index path is valid for scrolling.
    var lastRowIndexPath: IndexPath? {
        let lastSection: Int = (numberOfSections - 1)._clampedRowOrSection
        if lastSection == NSNotFound {
            return nil
        }
        
        let lastRow = (numberOfRows(inSection: lastSection) - 1)._clampedRowOrSection
        let lastRowIndexPath = IndexPath(row: lastRow, section: lastSection)
        
        return lastRowIndexPath
    }
}

private extension Int {
    var _clampedRowOrSection: Int {
        if self < 0 {
            return NSNotFound
        } else {
            return self
        }
    }
}

// ******************************* MARK: - Cells, Header and Footer Reuse and Dequeue

public extension UITableView {
    
    // ******************************* MARK: - Cell
    
    /// Simplifies cell registration. Xib name must be the same as class name.
    func registerNib(class: UITableViewCell.Type) {
        register(UINib(nibName: `class`.className, bundle: nil), forCellReuseIdentifier: `class`.className)
    }
    
    /// Simplifies cell dequeue.
    /// - parameter class: Cell's class.
    /// - parameter indexPath: Cell's index path.
    func dequeue<T: UITableViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T {
        var cell: T!
        UIView.performWithoutAnimation {
            cell = dequeueReusableCell(withIdentifier: `class`.className, for: indexPath) as? T
        }
        return cell
    }
    
    /// Simplifies configurable cell dequeue.
    typealias ConfigurableCell = UITableViewCell & Configurable
    func dequeueConfigurable(class: ConfigurableCell.Type, for indexPath: IndexPath) -> ConfigurableCell {
        var cell: ConfigurableCell!
        UIView.performWithoutAnimation {
            cell = dequeueReusableCell(withIdentifier: `class`.className, for: indexPath) as? ConfigurableCell
        }
        return cell
    }
    
    // ******************************* MARK: - Header and Footer
    
    /// Simplifies header/footer registration. Xib name must be the same as class name.
    func registerNib(class: UITableViewHeaderFooterView.Type) {
        register(UINib(nibName: `class`.className, bundle: nil), forHeaderFooterViewReuseIdentifier: `class`.className)
    }
    
    /// Simplifies header/footer dequeue.
    /// - parameter class: Header or footer class.
    func dequeue<T: UITableViewHeaderFooterView>(_ class: T.Type) -> T {
        var view: T!
        UIView.performWithoutAnimation {
            view = dequeueReusableHeaderFooterView(withIdentifier: `class`.className) as? T
        }
        return view
    }
}

// ******************************* MARK: - Reload

public extension UITableView {
    /// Assures content offeset won't change after reload
    @available(*, renamed: "reloadDataKeepingBottomContentOffset")
    func reloadDataKeepingContentOffset() {
        reloadDataKeepingBottomContentOffset()
    }
    
    /// Assures bottom content offeset won't change after reload
    func reloadDataKeepingBottomContentOffset() {
        let bottomOffset = contentSize.height - (contentOffset.y + bounds.height)
        reloadData()
        layoutIfNeeded()
        contentOffset.y = contentSize.height - (bottomOffset + bounds.height)
    }
    
    /// Assures content offeset won't change after updating cells size
    func updateCellSizesKeepingContentOffset() {
        let bottomOffset = contentOffset.y
        beginUpdates()
        endUpdates()
        contentOffset.y = bottomOffset
    }
}

// ******************************* MARK: - Other

public extension UITableView {
    
    /// IndexPaths of visible cells
    var visibleIndexPaths: [IndexPath] {
        visibleCells.compactMap { indexPath(for: $0) }
    }
}
