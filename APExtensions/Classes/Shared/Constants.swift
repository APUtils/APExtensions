//
//  Constants.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/5/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation
import UIKit

public enum Constants {
    
    /// Coeficient that applies for font and constraint sizes when fit for screen size is enabled on element.
    /// - Tag: screenResizeCoef
    public static var screenResizeCoef: CGFloat = {
        let baseScreenSize: CGFloat = 414 // iPhone 6+
        let currentScreenSize = UIScreen.main.bounds.width
        return currentScreenSize / baseScreenSize
    }()
}

public let c: Constants.Type = Constants.self
