//
//  UIView+ViewModel.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 10/4/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

public extension UIView {
    enum Visibility {
        case hidden
        case visible
        case transparent
    }
    
    struct ViewModel {
        public var backgroundColor: UIColor?
        public var visibility: Visibility
        
        public init(backgroundColor: UIColor? = nil,
                    visibility: UIView.Visibility = .visible) {
            
            self.backgroundColor = backgroundColor
            self.visibility = visibility
        }
    }
    
    func configure(vm: ViewModel) {
        backgroundColor = vm.backgroundColor
        
        switch vm.visibility {
        case .hidden:
            isHidden = true
            alpha = 0
            
        case .visible:
            isHidden = false
            alpha = 1
            
        case .transparent:
            isHidden = false
            alpha = 0
        }
    }
}
