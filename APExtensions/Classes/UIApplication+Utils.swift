//
//  UIApplication+Utils.swift
//  Pods
//
//  Created by mac-246 on 7/14/17.
//
//

import UIKit


extension UIApplication {
    public static func makeCall(phone: String) {
        let urlString = "telprompt://\(phone)"
        guard let url = URL(string: urlString) else { return }
        
        shared.openURL(url)
    }
}
