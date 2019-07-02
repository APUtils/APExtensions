//
//  UIView+ViewConfiguration.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 10/4/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIView {
    enum ViewState {
        case hidden
        case shown
        case transparent
    }
    
    func configure(viewState: ViewState) {
        switch viewState {
        case .hidden:
            isHidden = true
            
        case .shown:
            isHidden = false
            alpha = 1
            
        case .transparent:
            isHidden = false
            alpha = 0
        }
    }
}
