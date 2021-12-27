//
//  UITextField+ViewModel.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 10/4/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UITextField {
    
    struct ViewModel {
        public var backgroundColor: UIColor?
        public var placeholder: String?
        public var text: String?
        public var textColor: UIColor?
        public var visibility: Visibility
        
        public var viewVM: UIView.ViewModel {
            .init(backgroundColor: backgroundColor,
                  visibility: visibility)
        }
        
        public init(backgroundColor: UIColor? = nil,
                    placeholder: String? = nil,
                    text: String? = nil,
                    textColor: UIColor? = nil,
                    visibility: Visibility = .visible) {
            
            self.backgroundColor = backgroundColor
            self.placeholder = placeholder
            self.text = text
            self.textColor = textColor
            self.visibility = visibility
        }
    }
    
    func configure(vm: ViewModel) {
        configure(vm: vm.viewVM)
        
        placeholder = vm.placeholder
        text = vm.text
        textColor = vm.textColor
    }
}
