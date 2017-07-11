//
//  TableView.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 19.05.16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit


/// TableView with decreased button touch delay
public class TableView: UITableView {
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization, Setup and Configuration
    //-----------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        delaysContentTouches = false
        
        for view in subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delaysContentTouches = false
                break
            }
        }
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - UIScrollView Methods
    //-----------------------------------------------------------------------------
    
    override public func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return true
        }
        
        return super.touchesShouldCancel(in: view)
    }
}
