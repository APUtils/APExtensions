//
//  UIColor+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 09/04/16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import RoutableLogger
import UIKit

public extension UIColor {
    
    /// Init color from 0-255 RGB components
    convenience init(red: Int, green: Int, blue: Int) {
        if !(red >= 0 && red <= 255) {
            RoutableLogger.logError("Invalid red component", data: ["red": red, "green": green, "blue": blue])
        }
        
        if !(green >= 0 && green <= 255) {
            RoutableLogger.logError("Invalid green component", data: ["red": red, "green": green, "blue": blue])
        }
        
        if !(blue >= 0 && blue <= 255) {
            RoutableLogger.logError("Invalid blue component", data: ["red": red, "green": green, "blue": blue])
        }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// Init color from hex value
    convenience init(hex: Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    /// Return lighter color. 1.0 - white, 0.0 - same as receiver.
    func lighterColor(amount: CGFloat) -> UIColor {
        let amount = min(max(amount, 0), 1)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let newRed = red + (1 - red) * amount
            let newGreen = green + (1 - green) * amount
            let newBlue = blue + (1 - blue) * amount
            let newAlpha = alpha + (1 - alpha) * amount
            
            return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
        } else {
            return self
        }
    }
}

// ******************************* MARK: - Average Color

public extension UIColor {
    
    /// Return average color by combining averages for `red`, `green`, `blue` and `alpha` components.
    static func hexAverage(colors: [UIColor]) -> UIColor {
        var averageRed: CGFloat = 0
        var averageGreen: CGFloat = 0
        var averageBlue: CGFloat = 0
        var averageAlpha: CGFloat = 0
        colors.forEach({ color in
            var currentRed: CGFloat = 0
            var currentGreen: CGFloat = 0
            var currentBlue: CGFloat = 0
            var currentAlpha: CGFloat = 0
            color.getRed(&currentRed, green: &currentGreen, blue: &currentBlue, alpha: &currentAlpha)
            averageRed += currentRed
            averageGreen += currentGreen
            averageBlue += currentBlue
            averageAlpha += currentAlpha
        })
        
        let count = CGFloat(colors.count)
        averageRed /= count
        averageGreen /= count
        averageBlue /= count
        averageAlpha /= count
        
        return UIColor(red: averageRed, green: averageGreen, blue: averageBlue, alpha: averageAlpha)
    }
    
    /// Returns average color by combining averages of `hue`, `saturation`, `brightness` and `alpha` components.
    /// This one is close to human understanable average.
    static func hueAverage(colors: [UIColor]) -> UIColor {
        var averageHue: CGFloat = 0
        var averageSaturation: CGFloat = 0
        var averageBrightness: CGFloat = 0
        var averageAlpha: CGFloat = 0
        colors.forEach({ color in
            var currentHue: CGFloat = 0
            var currentSaturation: CGFloat = 0
            var currentBrightness: CGFloat = 0
            var currentAlpha: CGFloat = 0
            color.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrightness, alpha: &currentAlpha)
            averageHue += currentHue
            averageSaturation += currentSaturation
            averageBrightness += currentBrightness
            averageAlpha += currentAlpha
        })
        
        let count = CGFloat(colors.count)
        averageHue /= count
        averageSaturation /= count
        averageBrightness /= count
        averageAlpha /= count
        
        return UIColor(hue: averageHue, saturation: averageSaturation, brightness: averageBrightness, alpha: averageAlpha)
    }
}

// ******************************* MARK: - Other

public extension UIColor {
    
    func applicationResolvedColor(viewController: UIViewController, file: String = #file, function: String = #function, line: UInt = #line) -> UIColor {
        guard #available(iOS 13.0, *) else { return self }
        
        if viewController.window != nil {
            return resolvedColor(with: viewController.traitCollection)
        } else if let window = UIApplication.shared.delegate?.window ?? nil {
            return resolvedColor(with: window.traitCollection)
        } else {
            return resolvedColor(with: viewController.traitCollection)
        }
    }
    
    /// Resolves color using application's delegate window if `view` is not yet added to `window`
    func applicationResolvedColor(view: UIView? = nil, file: String = #file, function: String = #function, line: UInt = #line) -> UIColor {
        guard #available(iOS 13.0, *) else { return self }
        
        if let view, view.window != nil {
            return resolvedColor(with: view.traitCollection)
        } else if let window = UIApplication.shared.delegate?.window ?? nil {
            return resolvedColor(with: window.traitCollection)
        } else if let view {
            return resolvedColor(with: view.traitCollection)
        } else {
            return resolvedColor(with: UITraitCollection.current)
        }
    }
}
