//
//  NSMutableAttributedString+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/18/18.
//  Copyright © 2018 Anton Plebanovich. All rights reserved.
//

import UIKit


extension NSMutableAttributedString {
    /// Range from the start to the end
    public var fullRange: NSRange {
        return NSRange(location: 0, length: length)
    }
    
    public func set(font: UIFont, for text: String) {
        let range = mutableString.range(of: text)
        guard range.location != NSNotFound else { return }
        
        let attributes: [NSAttributedStringKey: Any] = [.font: font]
        addAttributes(attributes, range: range)
    }
}
