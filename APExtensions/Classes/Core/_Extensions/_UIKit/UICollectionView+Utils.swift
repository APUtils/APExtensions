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
        register(nib,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: headerClass.className)
    }
    
    /// Simplifies footer registration. Xib name must be the same as class name.
    func registerNib(footerClass: UICollectionReusableView.Type) {
        let nib = UINib(nibName: footerClass.className, bundle: nil)
        register(nib,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: footerClass.className)
    }
    
    /// Simplifies cell registration. Xib name must be the same as class name.
    func registerNib(cellClass: UICollectionViewCell.Type) {
        let nib = UINib(nibName: cellClass.className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellClass.className)
    }
    
    /// Simplifies cell dequeue.
    func dequeueCell<T: UICollectionViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T {
        var cell: T!
        UIView.performWithoutAnimation {
            cell = dequeueReusableCell(withReuseIdentifier: `class`.className,
                                       for: indexPath) as? T
        }
        return cell
    }
    
    /// Simplifies configurable cell dequeue.
    func dequeueConfigurableCell(class: (UICollectionViewCell & Configurable).Type, for indexPath: IndexPath) -> UICollectionViewCell & Configurable {
        var cell: (UICollectionViewCell & Configurable)!
        UIView.performWithoutAnimation {
            cell = dequeueReusableCell(withReuseIdentifier: `class`.className,
                                       for: indexPath) as? UICollectionViewCell & Configurable
        }
        return cell
    }
    
    /// Simplifies header dequeue. Specify type of variable on declaration so proper header will be dequeued.
    /// Example:
    ///
    ///     let header: MyHeader = collectionView.dequeueHeader(for: indexPath)
    func dequeueHeader<T: UICollectionReusableView>(_ class: T.Type, for indexPath: IndexPath) -> T {
        var header: T!
        UIView.performWithoutAnimation {
            header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                      withReuseIdentifier: `class`.className,
                                                      for: indexPath) as? T
        }
        return header
    }
    
    /// Simplifies configurable header dequeue.
    ///
    /// Example:
    ///
    ///     let cell = collectionView.dequeueConfigurableHeader(class: MyHeaderClass.self, for: indexPath)
    func dequeueConfigurableHeader(class: (UICollectionReusableView & Configurable).Type, for indexPath: IndexPath) -> UICollectionReusableView & Configurable {
        var header: (UICollectionReusableView & Configurable)!
        UIView.performWithoutAnimation {
            header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                      withReuseIdentifier: `class`.className,
                                                      for: indexPath) as? UICollectionReusableView & Configurable
        }
        return header
    }
    
    /// Simplifies footer dequeue.
    func dequeueFooter<T: UICollectionReusableView>(_ class: T.Type, for indexPath: IndexPath) -> T {
        var footer: T!
        UIView.performWithoutAnimation {
            footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                      withReuseIdentifier: `class`.className,
                                                      for: indexPath) as? T
        }
        return footer
    }
    
    /// Simplifies configurable footer dequeue.
    ///
    /// Example:
    ///
    ///     let cell = collectionView.dequeueConfigurableFooter(class: MyFooterClass.self, for: indexPath)
    func dequeueConfigurableFooter(class: (UICollectionReusableView & Configurable).Type, for indexPath: IndexPath) -> UICollectionReusableView & Configurable {
        var footer: (UICollectionReusableView & Configurable)!
        UIView.performWithoutAnimation {
            footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                      withReuseIdentifier: `class`.className,
                                                      for: indexPath) as? UICollectionReusableView & Configurable
        }
        return footer
    }
}
