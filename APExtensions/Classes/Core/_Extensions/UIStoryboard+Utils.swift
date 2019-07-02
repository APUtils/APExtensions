//
//  UIStoryboard+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 13/03/16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIStoryboard {
    /// Instantiates initial view controller from storyboard
    class func controller(storyboardName: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        
        return controller
    }
}
