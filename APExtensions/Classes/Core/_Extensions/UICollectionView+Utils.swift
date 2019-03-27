//
//  UICollectionView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 01/02/2017.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UICollectionView {
    
    // ******************************* MARK: - Cell Nib
    
    /// Simplifies header registration. Xib name must be the same as class name.
    func registerNib(headerClass: UICollectionReusableView.Type) {
        let nib = UINib(nibName: headerClass.className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerClass.className)
    }
    
    /// Simplifies footer registration. Xib name must be the same as class name.
    func registerNib(footerClass: UICollectionReusableView.Type) {
        let nib = UINib(nibName: footerClass.className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerClass.className)
    }
    
    /// Simplifies cell registration. Xib name must be the same as class name.
    func registerNib(cellClass: UICollectionViewCell.Type) {
        register(UINib(nibName: cellClass.className, bundle: nil), forCellWithReuseIdentifier: cellClass.className)
    }
    
    /// Simplifies cell dequeue. Specify type of variable on declaration so proper cell will be dequeued.
    /// Example:
    ///
    ///     let cell: MyCell = collectionView.dequeueCell(for: indexPath)
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
    }
    
    /// Simplifies cell dequeue.
    ///
    ///     let cell = collectionView.dequeueCell(MyCell.self, for: indexPath)
    func dequeueCell<T: UICollectionViewCell>(_ class: T, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: `class`.className, for: indexPath) as! T
    }
    
    /// Simplifies configurable cell dequeue.
    ///
    /// Example:
    ///
    ///     let cell = collectionView.dequeueConfigurableCell(class: MyCellClass.self, for: indexPath)
    func dequeueConfigurableCell(class: (UICollectionViewCell & Configurable).Type, for indexPath: IndexPath) -> UICollectionViewCell & Configurable {
        return dequeueReusableCell(withReuseIdentifier: `class`.className, for: indexPath) as! UICollectionViewCell & Configurable
    }
    
    /// Simplifies header dequeue. Specify type of variable on declaration so proper header will be dequeued.
    /// Example:
    ///
    ///     let header: MyHeader = collectionView.dequeueHeader(for: indexPath)
    func dequeueHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.className, for: indexPath) as! T
    }
    
    /// Simplifies header dequeue.
    ///
    ///     let header = collectionView.dequeueHeader(MyHeader.self, for: indexPath)
    func dequeueHeader<T: UICollectionReusableView>(_ class: T, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: `class`.className, for: indexPath) as! T
    }
    
    /// Simplifies configurable header dequeue.
    ///
    /// Example:
    ///
    ///     let cell = collectionView.dequeueConfigurableHeader(class: MyHeaderClass.self, for: indexPath)
    func dequeueConfigurableHeader(class: (UICollectionReusableView & Configurable).Type, for indexPath: IndexPath) -> UICollectionReusableView & Configurable {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: `class`.className, for: indexPath) as! UICollectionReusableView & Configurable
    }
    
    /// Simplifies footer dequeue. Specify type of variable on declaration so proper footer will be dequeued.
    /// Example:
    ///
    ///     let footer: MyFooter = collectionView.dequeueFooter(for: indexPath)
    func dequeueFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.className, for: indexPath) as! T
    }
    
    /// Simplifies footer dequeue.
    ///
    ///     let footer = collectionView.dequeueFooter(MyFooter.self, for: indexPath)
    func dequeueFooter<T: UICollectionReusableView>(_ class: T, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: `class`.className, for: indexPath) as! T
    }
    
    /// Simplifies configurable footer dequeue.
    ///
    /// Example:
    ///
    ///     let cell = collectionView.dequeueConfigurableFooter(class: MyFooterClass.self, for: indexPath)
    func dequeueConfigurableFooter(class: (UICollectionReusableView & Configurable).Type, for indexPath: IndexPath) -> UICollectionReusableView & Configurable {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: `class`.className, for: indexPath) as! UICollectionReusableView & Configurable
    }
}
