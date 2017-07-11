//
//  NSDate+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 19/03/16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import Foundation


private var timeAndDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    
    return formatter
}()


public extension Date {
    public var timeAndDateString: String {
        let formatter = timeAndDateFormatter
        let string = formatter.string(from: self)
        
        return string
    }
}
