//
//  EstimatedRowHeightController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/2/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

/// Controller that improves UITableView scrolling and animation experience.
/// - Note: You should assign tableView's `delegate` first and then create
/// and store `EstimatedRowHeightController`. Everything else is automatic.
class EstimatedRowHeightController: NSObject, UITableViewDelegate {
    
    // ******************************* MARK: - Private Properties
    
    private weak var tableView: UITableView?
    private weak var originalTableViewDelegate: UITableViewDelegate?
    private var estimatedHeights: [IndexPath: CGFloat] = [:]
    
    // ******************************* MARK: - Initialization and Setup
    
    private override init() { fatalError("Use init(tableView:) instead") }
    
    init(tableView: UITableView) {
        UITableView._setupOnce
        self.tableView = tableView
        self.originalTableViewDelegate = tableView.delegate
        super.init()
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onIndexPathChange(_:)),
                                               name: .uiTableView_IndexPathChanged_NotificationName,
                                               object: tableView)
    }
    
    deinit {
        tableView?.delegate = originalTableViewDelegate
    }
    
    // ******************************* MARK: - NSObject Methods
    
    override func responds(to aSelector: Selector!) -> Bool {
        var responds = super.responds(to: aSelector)
        
        if let originalTableViewDelegate = originalTableViewDelegate {
            responds = responds || originalTableViewDelegate.responds(to: aSelector)
        }
        
        return responds
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let target = super.forwardingTarget(for: aSelector) {
            return target
        } else if let originalTableViewDelegate = originalTableViewDelegate, originalTableViewDelegate.responds(to: aSelector) {
            return originalTableViewDelegate
        } else {
            return nil
        }
    }
    
    // ******************************* MARK: - Notifications
    
    @objc private func onIndexPathChange(_ notification: Notification) {
        guard let tableView = tableView else { return }
        
        // -- open func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
        // When this method is called in an animation block defined by the beginUpdates()
        // and endUpdates() methods, it behaves similarly to deleteRows(at:with:).
        // The indexes that UITableView passes to the method are specified in the state
        // of the table view prior to any updates. This happens regardless of ordering of the
        // insertion, deletion, and reloading method calls within the animation block.
        
        // -- open func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
        // Deletes are processed before inserts in batch operations.
        // This means the indexes for the deletions are processed relative
        // to the indexes of the table view’s state before the batch operation,
        // and the indexes for the insertions are processed relative
        // to the indexes of the state after all the deletions in the batch operation.
        
        // -- open func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
        // When this method is called in an animation block defined by the beginUpdates() and endUpdates()
        // methods, UITableView defers any insertions of rows or sections until after it has handled
        // the deletions of rows or sections. This order is followed regardless of how the insertion
        // and deletion method calls are ordered. This is unlike inserting or removing an item in
        // a mutable array, in which the operation can affect the array index used for the successive
        // insertion or removal operation.
        
        // Let's ignore moves for now since there isn't enough of how it behave and when to apply it
        
        // estimatedHeights.keys.map { $0.row }.sorted().forEach { print($0) }
        // First, let's invalidate reloads
        tableView.reloadIndexPaths.forEach {
            estimatedHeights[$0] = nil
        }
        
        // Second, let's handle deletions.
        // We need to clear actual deleted index paths and then process all others
        // decreasing their row number if they have higher row index.
        tableView.deleteIndexPaths.forEach { deleteIndexPath in
            estimatedHeights[deleteIndexPath] = nil
            estimatedHeights = estimatedHeights.mapDictionary { indexPath, value in
                guard indexPath.section == deleteIndexPath.section, indexPath.row > deleteIndexPath.row else {
                    return (indexPath, value)
                }
                
                let newIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
                return (newIndexPath, value)
            }
        }
        
        // Third, let's handle insertions.
        // We need to increase all index path's row value that are placed higher or equal in index
        tableView.insertIndexPaths.forEach { insertIndexPath in
            estimatedHeights = estimatedHeights.mapDictionary { indexPath, value in
                guard indexPath.section == insertIndexPath.section, indexPath.row >= insertIndexPath.row else {
                    return (indexPath, value)
                }
                
                let newIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                return (newIndexPath, value)
            }
        }
        
        // Welp, wasn't hard after all just need to recheck everything.
    }
    
    // ******************************* MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = originalTableViewDelegate?.tableView?(tableView, estimatedHeightForRowAt: indexPath) {
            return height
        } else {
            if let estimatedHeight = estimatedHeights[indexPath] {
                return estimatedHeight
            } else {
                // Try guess and return average value
                let sameSectionIndexPaths = estimatedHeights.keys.filter({ $0.section == indexPath.section })
                if sameSectionIndexPaths.hasElements {
                    return sameSectionIndexPaths.compactMap { estimatedHeights[$0] }.average()
                } else {
                    return UITableView.automaticDimension
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Prevent cell stuck in zero size.
        // Table view won't queue for actual height if 0 is returned for estimated.
        if cell.bounds.height > 0 {
            estimatedHeights[indexPath] = cell.bounds.height
        } else {
            estimatedHeights[indexPath] = nil
        }
        
        originalTableViewDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        estimatedHeights[indexPath] = cell.bounds.height
        originalTableViewDelegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
}

// ******************************* MARK: - Swizzle Functions

private func swizzleClassMethods(class: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    guard class_isMetaClass(`class`) else { return }
    
    let originalMethod = class_getClassMethod(`class`, originalSelector)!
    let swizzledMethod = class_getClassMethod(`class`, swizzledSelector)!
    
    swizzleMethods(class: `class`, originalSelector: originalSelector, originalMethod: originalMethod, swizzledSelector: swizzledSelector, swizzledMethod: swizzledMethod)
}

private func swizzleMethods(class: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    guard !class_isMetaClass(`class`) else { return }
    
    let originalMethod = class_getInstanceMethod(`class`, originalSelector)!
    let swizzledMethod = class_getInstanceMethod(`class`, swizzledSelector)!
    
    swizzleMethods(class: `class`, originalSelector: originalSelector, originalMethod: originalMethod, swizzledSelector: swizzledSelector, swizzledMethod: swizzledMethod)
}

private func swizzleMethods(class: AnyClass, originalSelector: Selector, originalMethod: Method, swizzledSelector: Selector, swizzledMethod: Method) {
    let didAddMethod = class_addMethod(`class`, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
    
    if didAddMethod {
        class_replaceMethod(`class`, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

// ******************************* MARK: - Load

private extension UITableView {
    static let _setupOnce: Void = {
        
        if #available(iOS 11.0, *) {
            swizzleMethods(class: UITableView.self, originalSelector: #selector(performBatchUpdates(_:completion:)), swizzledSelector: #selector(_apextensions_performBatchUpdates(_:completion:)))
        }
        
        swizzleMethods(class: UITableView.self, originalSelector: #selector(beginUpdates), swizzledSelector: #selector(_apextensions_beginUpdates))
        swizzleMethods(class: UITableView.self, originalSelector: #selector(endUpdates), swizzledSelector: #selector(_apextensions_endUpdates))
        swizzleMethods(class: UITableView.self, originalSelector: #selector(insertRows(at:with:)), swizzledSelector: #selector(_apextensions_insertRows(at:with:)))
        swizzleMethods(class: UITableView.self, originalSelector: #selector(deleteRows(at:with:)), swizzledSelector: #selector(_apextensions_deleteRows(at:with:)))
        swizzleMethods(class: UITableView.self, originalSelector: #selector(reloadRows(at:with:)), swizzledSelector: #selector(_apextensions_reloadRows(at:with:)))
        swizzleMethods(class: UITableView.self, originalSelector: #selector(moveRow(at:to:)), swizzledSelector: #selector(_apextensions_moveRow(at:to:)))
    }()
}

// ******************************* MARK: - UITableView Methods Listening

private extension NSNotification.Name {
    static let uiTableView_IndexPathChanged_NotificationName = NSNotification.Name("uiTableView_IndexPathChanged_NotificationName")
}

private var c_isUpdatingAssociationKey = 0
private var c_insertIndexPathsAssociationKey = 0
private var c_deleteIndexPathsAssociationKey = 0
private var c_reloadIndexPathsAssociationKey = 0
private var c_moveIndexPathsAssociationKey = 0

private extension UITableView {
    
    var isUpdating: Bool {
        get {
            return objc_getAssociatedObject(self, &c_isUpdatingAssociationKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &c_isUpdatingAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var insertIndexPaths: [IndexPath] {
        get {
            return objc_getAssociatedObject(self, &c_insertIndexPathsAssociationKey) as? [IndexPath] ?? []
        }
        set {
            objc_setAssociatedObject(self, &c_insertIndexPathsAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var deleteIndexPaths: [IndexPath] {
        get {
            return objc_getAssociatedObject(self, &c_deleteIndexPathsAssociationKey) as? [IndexPath] ?? []
        }
        set {
            objc_setAssociatedObject(self, &c_deleteIndexPathsAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var reloadIndexPaths: [IndexPath] {
        get {
            return objc_getAssociatedObject(self, &c_reloadIndexPathsAssociationKey) as? [IndexPath] ?? []
        }
        set {
            objc_setAssociatedObject(self, &c_reloadIndexPathsAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    typealias MoveTuple = (from: IndexPath, to: IndexPath)
    var moveIndexPaths: [MoveTuple] {
        get {
            return objc_getAssociatedObject(self, &c_moveIndexPathsAssociationKey) as? [MoveTuple] ?? []
        }
        set {
            objc_setAssociatedObject(self, &c_moveIndexPathsAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @available(iOS 11.0, *)
    @objc private func _apextensions_performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        
        isUpdating = true
        _apextensions_performBatchUpdates(updates, completion: { success in
            NotificationCenter.default.post(name: .uiTableView_IndexPathChanged_NotificationName, object: self)
            self.insertIndexPaths = []
            self.deleteIndexPaths = []
            self.reloadIndexPaths = []
            self.moveIndexPaths = []
            
            completion?(success)
            self.isUpdating = false
        })
    }
    
    @objc private func _apextensions_beginUpdates() {
        isUpdating = true
        _apextensions_beginUpdates()
    }
    
    @objc private func _apextensions_endUpdates() {
        NotificationCenter.default.post(name: .uiTableView_IndexPathChanged_NotificationName, object: self)
        insertIndexPaths = []
        deleteIndexPaths = []
        reloadIndexPaths = []
        moveIndexPaths = []
        
        _apextensions_endUpdates()
        isUpdating = false
    }
    
    @objc private func _apextensions_insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        insertIndexPaths.append(contentsOf: indexPaths)
        if !isUpdating {
            NotificationCenter.default.post(name: .uiTableView_IndexPathChanged_NotificationName, object: self)
            insertIndexPaths = []
        }
        
        _apextensions_insertRows(at: indexPaths, with: animation)
    }
    
    @objc private func _apextensions_deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        deleteIndexPaths.append(contentsOf: indexPaths)
        if !isUpdating {
            NotificationCenter.default.post(name: .uiTableView_IndexPathChanged_NotificationName, object: self)
            deleteIndexPaths = []
        }
        
        _apextensions_deleteRows(at: indexPaths, with: animation)
    }
    
    @objc private func _apextensions_reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        reloadIndexPaths.append(contentsOf: indexPaths)
        if !isUpdating {
            NotificationCenter.default.post(name: .uiTableView_IndexPathChanged_NotificationName, object: self)
            reloadIndexPaths = []
        }
        
        _apextensions_reloadRows(at: indexPaths, with: animation)
    }
    
    @objc private func _apextensions_moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        moveIndexPaths.append((from: indexPath, to: newIndexPath))
        if !isUpdating {
            NotificationCenter.default.post(name: .uiTableView_IndexPathChanged_NotificationName, object: self)
            moveIndexPaths = []
        }
        
        _apextensions_moveRow(at: indexPath, to: newIndexPath)
    }
}
