//
//  UIImage+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/20/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    /// Creates image from contents of local file
    /// - return: Returns nil if image can not be created or file can not be found.
    @available(iOS 9.0, *)
    convenience init?(contentsOfFile file: URL) {
        guard file.isFileURL && !file.hasDirectoryPath else { return nil }
        
        self.init(contentsOfFile: file.path)
    }
    
    /// Returns image with overlay image drawn the center on top.
    func image(withOverlayImageAtCenter overlayImage: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        draw(at: CGPoint(x: 0, y: 0))
        let centerRectOrigin = CGPoint(x: (size.width - overlayImage.size.width) / 2, y: (size.height - overlayImage.size.height) / 2)
        let centerRect = CGRect(origin: centerRectOrigin, size: overlayImage.size)
        overlayImage.draw(in: centerRect)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        } else {
            return self
        }
    }
    
    /// Returns image with overlay image drawn in the `rect` on top.
    func image(withOverlayImage overlayImage: UIImage, inRect rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        draw(at: CGPoint(x: 0, y: 0))
        overlayImage.draw(in: rect)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            return image
        } else {
            return self
        }
    }
    
    /// Resizes specified image to required size. It uses aspect fill approach and high interpolation quality.
    /// - parameters:
    ///   - size: Required size.
    /// - returns: Resized image.
    func image(withSize size: CGSize) -> UIImage {
        guard self.size != size else { return self }
        
        let scale = max(size.width / self.size.width, size.height / self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high
        
        let scaledWidth = self.size.width * scale
        let scaledHeight = self.size.height * scale
        let originX = (size.width - scaledWidth) / 2
        let originY = (size.height - scaledHeight) / 2
        draw(in: CGRect(x: originX, y: originY, width: scaledWidth, height: scaledHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage ?? self
    }
}
