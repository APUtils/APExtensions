//
//  UITableView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 12/23/16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Cells, Header and Footer reuse

public extension UITableView {
    
    // ******************************* MARK: - Cell
    
    /// Simplifies cell registration. Xib name must be the same as class name.
    public func registerNib(class: UITableViewCell.Type) {
        register(UINib(nibName: `class`.className, bundle: nil), forCellReuseIdentifier: `class`.className)
    }
    
    /// Simplifies cell dequeue. Specify type of variable on declaration so proper cell will be dequeued.
    ///
    /// Example:
    ///
    ///     let cell: MyCell = tableView.dequeue(for: indexPath)
    public func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
    
    /// Simplifies configurable cell dequeue.
    ///
    /// Example:
    ///
    ///     let cell = tableView.dequeueConfigurable(cellClass: MyClass.self, for: indexPath)
    public func dequeueConfigurable(class: (UITableViewCell & Configurable).Type, for indexPath: IndexPath) -> UITableViewCell & Configurable {
        return dequeueReusableCell(withIdentifier: `class`.className, for: indexPath) as! UITableViewCell & Configurable
    }
    
    // ******************************* MARK: - Header and Footer
    
    /// Simplifies header/footer registration. Xib name must be the same as class name.
    public func registerNib(class: UITableViewHeaderFooterView.Type) {
        register(UINib(nibName: `class`.className, bundle: nil), forHeaderFooterViewReuseIdentifier: `class`.className)
    }
    
    /// Simplifies header/footer dequeue. Specify type of variable on declaration so proper cell will be dequeued.
    /// Example:
    ///
    ///     let view: MyHeaderFooter = tableView.dequeueReusableHeaderFooter()
    public func dequeue<T: UITableViewHeaderFooterView>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.className) as! T
    }
}

// ******************************* MARK: - Reload

public extension UITableView {
    /// Assures content offeset won't change after reload
    public func reloadDataKeepingContentOffset() {
        let bottomOffset = contentSize.height - (contentOffset.y + bounds.height)
        reloadData()
        layoutIfNeeded()
        contentOffset.y = contentSize.height - (bottomOffset + bounds.height)
    }
}

