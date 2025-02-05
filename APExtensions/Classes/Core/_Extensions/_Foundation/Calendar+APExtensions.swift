//
//  Calendar+APExtensions.swift
//  Pods
//
//  Created by Anton Plebanovich on 16.11.23.
//  Copyright © 2023 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension Calendar {
    
    /// Gregorian calendar
    static let gregorian: Calendar = Calendar(identifier: .gregorian)
    
    /// Make `Calendar` for provided `timeZone`
    static func make(timeZone: TimeZone) -> Calendar {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        
        return calendar
    }
}
