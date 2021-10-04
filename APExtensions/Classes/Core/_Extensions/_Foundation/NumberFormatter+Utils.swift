//
//  NumberFormatter+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 29.09.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension NumberFormatter {
    static let ceil: NumberFormatter = {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 0
        return nf
    }()
    
    static let tenth: NumberFormatter = {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    static let hundredth: NumberFormatter = {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    static let thousands: NumberFormatter = {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 3
        return nf
    }()
}
