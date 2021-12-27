//
//  UIButton+ViewModel.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 10/4/17.
//  
//

import UIKit

public extension UIButton {
    
    struct ViewModel {
        public var backgroundColor: UIColor?
        public var title: String?
        public var titleColor: UIColor?
        public var visibility: Visibility
        
        public var viewVM: UIView.ViewModel {
            .init(backgroundColor: backgroundColor,
                  visibility: visibility)
        }
        
        public init(backgroundColor: UIColor? = nil,
                    title: String? = nil,
                    titleColor: UIColor? = nil,
                    visibility: Visibility = .visible) {
            
            self.backgroundColor = backgroundColor
            self.title = title
            self.titleColor = titleColor
            self.visibility = visibility
        }
    }
    
    func configure(vm: ViewModel) {
        configure(vm: vm.viewVM)
        
        setTitle(vm.title, for: .normal)
        setTitleColor(vm.titleColor, for: .normal)
    }
}
