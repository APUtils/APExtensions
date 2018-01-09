//
//  UIApplication+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/14/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIApplication {
    
    // ******************************* MARK: - Class Methods
    
    /// Initiates call to `phone`
    public static func makeCall(phone: String) {
        let urlString = "telprompt://\(phone)"
        guard let url = URL(string: urlString) else { return }
        
        shared.openURL(url)
    }
}
