//
//  NSMutableAttributedString+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/18/18.
//  Copyright © 2018 Anton Plebanovich. All rights reserved.
//

import UIKit


extension NSMutableAttributedString {
    /// Sets font for first occurence of text. If text is nil sets font for entire string.
    func set(font: UIFont, for text: String? = nil) {
        let range: NSRange
        if let text = text {
            range = mutableString.range(of: text)
        } else {
            range = fullRange
        }
        
        guard range.location != NSNotFound else { return }
        
        addAttribute(.font, value: font, range: range)
    }
    
    /// Sets line spacing
    func set(lineSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)
    }
    
    /// Sets line height multiple
    func set(lineHeightMultiple: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: fullRange)
    }
    
    /// Set text kern
    func set(kern: CGFloat) {
        addAttribute(.kern, value: kern, range: fullRange)
    }
}
