//
//  UIImageView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/20/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIImageView {
    func setImageAnimated(_ image: UIImage) {
        UIView.transition(with: self, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.image = image
        }, completion: nil)
    }
}
