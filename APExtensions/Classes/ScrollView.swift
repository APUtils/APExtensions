//
//  ScrollView.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 19.05.16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit


/// ScrollView with decreased button touch delay
public class ScrollView: UIScrollView {
    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization, Setup and Configuration
    //-----------------------------------------------------------------------------
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 580))
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        delaysContentTouches = false
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - UIScrollView Methods
    //-----------------------------------------------------------------------------
    
    override public func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            return  true
        }
        
        return  super.touchesShouldCancel(in: view)
    }
}
