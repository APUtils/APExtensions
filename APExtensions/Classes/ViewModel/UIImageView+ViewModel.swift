//
//  UIImageView+ViewModel.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/11/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIImageView {
    
    struct ViewModel {
        public var backgroundColor: UIColor?
        public var image: UIImage?
        public var visibility: Visibility
        
        public var viewVM: UIView.ViewModel {
            .init(backgroundColor: backgroundColor,
                  visibility: visibility)
        }
        
        public init(backgroundColor: UIColor? = nil,
                    image: UIImage? = nil,
                    visibility: Visibility = .visible) {
            
            self.backgroundColor = backgroundColor
            self.image = image
            self.visibility = visibility
        }
    }
    
    func configure(vm: ViewModel) {
        configure(vm: vm.viewVM)
        
        image = vm.image
    }
}
