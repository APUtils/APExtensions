//
//  NSMutableAttributedString+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/18/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit
import RoutableLogger

public extension NSMutableAttributedString {
    
    /// Makes text underlined
    @discardableResult
    func set(color: UIColor, substring: String? = nil) -> Self {
        let range: NSRange
        if let substring {
            range = mutableString.range(of: substring)
        } else {
            range = fullRange
        }
        
        guard range.location != NSNotFound else {
            RoutableLogger.logError("Unable to locate text", data: ["substring": substring, "self": self])
            return self
        }
        
        addAttribute(.foregroundColor, value: color, range: range)
        
        return self
    }
    
    /// Sets font for the first occurence of text. If text is `nil` sets font for entire string.
    @discardableResult
    func set(font: UIFont, for text: String? = nil) -> Self {
        let range: NSRange
        if let text = text {
            range = mutableString.range(of: text)
        } else {
            range = fullRange
        }
        
        guard range.location != NSNotFound else {
            RoutableLogger.logError("Unable to locate text", data: ["text": text, "self": self])
            return self
        }
        
        addAttribute(.font, value: font, range: range)
        
        return self
    }
    
    /// Sets aligment for the first occurence of text. If text is `nil` sets aligment for entire string.
    @discardableResult
    func set(aligment: NSTextAlignment? = nil,
             headIndent: CGFloat? = nil,
             lineSpacing: CGFloat? = nil,
             lineHeightMultiple: CGFloat? = nil,
             for text: String? = nil) -> Self {
        
        let range: NSRange
        if let text = text {
            range = mutableString.range(of: text)
        } else {
            range = fullRange
        }
        
        guard range.location != NSNotFound else {
            RoutableLogger.logError("Unable to locate text", data: ["text": text, "self": self])
            return self
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        if let aligment = aligment { paragraphStyle.alignment = aligment }
        if let headIndent = headIndent { paragraphStyle.headIndent = headIndent }
        if let lineSpacing = lineSpacing { paragraphStyle.lineSpacing = lineSpacing }
        if let lineHeightMultiple = lineHeightMultiple { paragraphStyle.lineHeightMultiple = lineHeightMultiple }
        
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        
        return self
    }
    
    /// Sets text kern
    @discardableResult
    func set(kern: CGFloat) -> Self {
        addAttribute(.kern, value: kern, range: fullRange)
        return self
    }
    
    /// Makes text underlined
    @discardableResult
    func setUnderline() -> Self {
        addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: fullRange)
        return self
    }
    
    /// Makes text striked through
    @discardableResult
    func setStrikethrough(text: String? = nil) -> Self {
        let range: NSRange
        if let text = text {
            range = mutableString.range(of: text)
        } else {
            range = fullRange
        }
        
        guard range.location != NSNotFound else {
            RoutableLogger.logError("Unable to locate text", data: ["text": text, "self": self])
            return self
        }
        
        addAttribute(NSAttributedString.Key.baselineOffset, value: 0, range: range)
        addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
        return self
    }
}
