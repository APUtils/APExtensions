//
//  UIImage+Storyboard.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 22.02.16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIImageView {
    /// Scale image for screen
    @IBInspectable var fitSize: Bool {
        get {
            return false
        }
        set {
            guard newValue else { return }
            guard let oldImage = self.image else { return }
            guard UIScreen.main.scale == 2 else { return } // Ignore 1x and 3x screens
            
            // Assuming we don't have 2x image in assets folder. 6+ size is 1242x2208.
            let resizeCoef = UIScreen.main.bounds.width * UIScreen.main.scale / 1242
            let newImageSize = CGSize(width: oldImage.size.width * resizeCoef, height: oldImage.size.height * resizeCoef)
            
            // Resizing image
            UIGraphicsBeginImageContextWithOptions(newImageSize, false, 0); // 0 == device main screen scale
            let context = UIGraphicsGetCurrentContext()
            context?.interpolationQuality = .high
            oldImage.draw(in: CGRect(x: 0, y: 0, width: newImageSize.width, height: newImageSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            self.image = newImage
        }
    }
    
    /// Using localized "_en" key to append to image. Won't work if you don't have "_en" key in your localized strings.
    @IBInspectable var localizedImageName: String? {
        get {
            return nil
        }
        set {
            guard let newValue = newValue else { return }
            
            let localizedImageName = newValue + g_Translate("_en")
            
            image = UIImage(named: localizedImageName)
        }
    }
}
