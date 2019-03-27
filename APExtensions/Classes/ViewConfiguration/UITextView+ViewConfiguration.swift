//
//  UITextView+ViewConfiguration.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 10/4/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UITextView {
    enum TextViewState {
        case hidden
        case shown(text: String?)
        case transparent
        
        public var text: String? {
            switch self {
            case .hidden, .transparent: return nil
            case .shown(let text): return text
            }
        }
    }
    
    func configure(textViewState: TextViewState) {
        switch textViewState {
        case .hidden:
            isHidden = true
            
        case .shown(let _text):
            text = _text
            isHidden = false
            alpha = 1
            
        case .transparent:
            isHidden = false
            alpha = 0
        }
    }
}
