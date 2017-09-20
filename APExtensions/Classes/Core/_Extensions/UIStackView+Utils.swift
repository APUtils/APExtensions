//
//  UIStackView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/20/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


@available(iOS 9.0, *)
public extension UIStackView {
    public func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    public func setArrangedSubviews(views: [UIView]) {
        removeAllSubviews()
        views.forEach(addSubview(_:))
    }
}
