//
//  Date+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/21/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import Foundation

//-----------------------------------------------------------------------------
// MARK: - Components
//-----------------------------------------------------------------------------

public extension Date {
    public static var today: Date {
        var components = Date().components
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return Calendar.current.date(from: components)!
    }
    
    public var components: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
    }
    
    public func isSameDay(withDate date: Date) -> Bool {
        let selfComponents = components
        let otherComponents = date.components
        
        return selfComponents.year == otherComponents.year && selfComponents.month == otherComponents.month && selfComponents.day == otherComponents.day
    }
}

//-----------------------------------------------------------------------------
// MARK: - String Representation
//-----------------------------------------------------------------------------

public extension Date {
    public func getString(dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short, doesRelativeDateFormatting: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
        
        return formatter.string(from: self)
    }
}
