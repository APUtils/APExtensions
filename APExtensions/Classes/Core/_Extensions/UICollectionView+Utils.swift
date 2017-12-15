//
//  UICollectionView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 01/02/2017.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UICollectionView {
    
    // ******************************* MARK: - Cell Nib
    
    /// Simplifies cell registration. Xib name must be the same as class name.
    public func registerNib(class: UICollectionViewCell.Type) {
        register(UINib(nibName: `class`.className, bundle: nil), forCellWithReuseIdentifier: `class`.className)
    }
    
    /// Simplifies cell dequeue. Specify type of variable on declaration so proper cell will be dequeued.
    /// Example:
    ///
    ///     let cell: MyCell = collectionView.dequeue(for: indexPath)
    public func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
    }
}
