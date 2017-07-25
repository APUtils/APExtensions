//
//  UIButton+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/25/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


extension UIButton {
    /// Sets button's title for control state normal without animations
    func setTitle(_ title: String?) {
        UIView.performWithoutAnimation {
            setTitle(title, for: .normal)
            layoutIfNeeded()
        }
    }
}
