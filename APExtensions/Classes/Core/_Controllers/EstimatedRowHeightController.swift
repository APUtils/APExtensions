//
//  EstimatedRowHeightController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/2/18.
//  Copyright © 2018 Anton Plebanovich. All rights reserved.
//

import UIKit


/// Controller that improves UITableView scrolling and animation experience
/// when cells height is dynamic on load but constant after that.
/// - Note: You should assign tableView's `delegate` first and then create
/// and store `EstimatedRowHeightController`. Everything else is automatic.
public class EstimatedRowHeightController: NSObject, UITableViewDelegate {
    
    // ******************************* MARK: - Private Properties
    
    private weak var originalTableViewDelegate: UITableViewDelegate?
    
    private var estimatedHeights: [IndexPath: CGFloat] = [:]
    
    // ******************************* MARK: - Initialization and Setup
    
    private override init() { super.init() }
    
    public init(tableView: UITableView) {
        self.originalTableViewDelegate = tableView.delegate
        super.init()
        tableView.delegate = self
    }
    
    // ******************************* MARK: - NSObject Methods
    
    override public func responds(to aSelector: Selector!) -> Bool {
        var responds = super.responds(to: aSelector)
        
        if let originalTableViewDelegate = originalTableViewDelegate {
            responds = responds || originalTableViewDelegate.responds(to: aSelector)
        }
        
        return responds
    }
    
    override public func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let target = super.forwardingTarget(for: aSelector) {
            return target
        } else if let originalTableViewDelegate = originalTableViewDelegate, originalTableViewDelegate.responds(to: aSelector) {
            return originalTableViewDelegate
        } else {
            return nil
        }
    }
    
    // ******************************* MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = originalTableViewDelegate?.tableView?(tableView, estimatedHeightForRowAt: indexPath) {
            return height
        } else {
            return estimatedHeights[indexPath] ?? UITableViewAutomaticDimension
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        estimatedHeights[indexPath] = cell.bounds.height
        originalTableViewDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
}
