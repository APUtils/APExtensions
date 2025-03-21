//
//  UILabel+ViewModel.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/11/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

public extension UILabel {
    
    struct ViewModel {
        public var backgroundColor: UIColor?
        public var text: String?
        public var textColor: UIColor?
        public var visibility: Visibility?
        
        public var viewVM: UIView.ViewModel {
            if let visibility = visibility {
                return .init(backgroundColor: backgroundColor,
                      visibility: visibility)
            } else {
                let visible = text != nil && text != "" && text != " "
                return .init(backgroundColor: backgroundColor,
                             visibility: visible ? .visible : .hidden)
            }
        }
        
        public init(backgroundColor: UIColor? = nil,
                    text: String? = nil,
                    textColor: UIColor? = nil,
                    visibility: Visibility? = nil) {
            
            self.backgroundColor = backgroundColor
            self.text = text
            self.textColor = textColor
            self.visibility = visibility
        }
    }
    
    func configure(vm: ViewModel) {
        configure(vm: vm.viewVM)
        
        text = vm.text
        textColor = vm.textColor
    }
}
