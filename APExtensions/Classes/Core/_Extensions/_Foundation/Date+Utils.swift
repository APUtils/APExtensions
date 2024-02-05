//
//  Date+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/21/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation
import RoutableLogger

// ******************************* MARK: - Components

public extension Date {
    /// Get yesterday's day start date. Uses user's time zone.
    static var yesterday: Date {
        return Calendar.current.date(byAdding: DateComponents(day: -1), to: Date())!.startOfDay
    }
    
    /// Get today's day start date. Uses user's time zone.
    static var today: Date {
        return Calendar.current.startOfDay(for: Date())
    }
    
    /// Get tomorrow's day start date. Uses user's time zone.
    static var tomorrow: Date {
        return Calendar.current.date(byAdding: DateComponents(day: 1), to: Date())!.startOfDay
    }
    
    /// Get day start. Uses user's time zone.
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// Get date's components. Uses user's time zone.
    /// - components: year, month, day, hour, minute, second, timeZone, calendar.
    var components: DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone, .calendar], from: self)
    }
    
    /// Returns beginning of the previous day.
    var previousDay: Date {
        return Calendar.current.date(byAdding: DateComponents(day: -1), to: self)!.startOfDay
    }
    
    /// Returns beginning of the next work day excluding today. It just exludes weekends. Does not exclude holidays.
    var previousWorkDay: Date {
        var currentDate = previousDay
        
        // Skipping weekends
        while currentDate.isWeekend { currentDate = currentDate.previousDay }
        
        return currentDate
    }
    
    /// Returns beginning of the next day.
    var nextDay: Date {
        return Calendar.current.date(byAdding: DateComponents(day: 1), to: self)!.startOfDay
    }
    
    /// Returns beginning of the next work day excluding today. It just exludes weekends. Does not exclude holidays.
    var nextWorkDay: Date {
        var currentDate = nextDay
        
        // Skipping weekends
        while currentDate.isWeekend { currentDate = currentDate.nextDay }
        
        return currentDate
    }
    
    /// Checks if date is in yesterday's range. Uses user's time zone.
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    /// Checks if date is in today's range. Uses user's time zone.
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    /// Checks if date is in tomorrow's range. Uses user's time zone.
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    /// Checks if date is in weekend's range. Uses user's time zone.
    var isWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }
    
    /// Converts date to GMT time zone day start.
    var gmtDayBeginningDate: Date {
        let toGmtTimeInterval = TimeInterval(TimeZone.current.secondsFromGMT(for: self))
        
        return Date(timeInterval: toGmtTimeInterval, since: startOfDay)
    }
    
    /// Checks if dates are on same day. Uses user's time zone.
    func isSameDay(withDate date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    func adding(dateComponents: DateComponents) -> Date {
        if let date = Calendar.current.date(byAdding: dateComponents, to: self) {
            return date
        } else {
            RoutableLogger.logError("Can't add date components", data: ["dateComponents": dateComponents, "date": self])
            return self
        }
    }
}

// ******************************* MARK: - String Representation

public extension Date {
    
    @available(macOS 10.13, *)
    static let isoGmtWithMillisAndTimeZone: ISO8601DateFormatter = {
        let df = ISO8601DateFormatter()
        df.formatOptions = [
            .withInternetDateTime,
            .withDashSeparatorInDate,
            .withColonSeparatorInTime,
            .withFractionalSeconds,
        ]
        
        return df
    }()
    
    /// Return `self` as a date string with a ISO format including milliseconds. E.g. `2014-07-16T06:50:00.000`.
    /// GMT time zone is assumed. Useful to pass to backend.
    var asIsoWithMillisecondsDate: String {
        Self.isoGmtWithMillisAndTimeZone.string(from: self)
    }
    
    fileprivate static let logsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .gregorian
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .current
        
        return formatter
    }()
    
    /// Return `self` as a date string with a `yyyy-MM-dd` format. E.g. `2019-10-15`.
    /// Useful for logs.
    var asLogsDate: String {
        Self.logsDateFormatter.string(from: self)
    }
    
    fileprivate static let logsTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .gregorian
        formatter.dateFormat = "HH:mm:ss.SSS"
        formatter.timeZone = .current
        
        return formatter
    }()
    
    /// Return `self` as a time string with a `HH:mm:ss.SSS` format. E.g. `10:20:45.123`.
    /// Useful for logs.
    var asLogsTimeString: String {
        Self.logsTimeFormatter.string(from: self)
    }
    
    fileprivate static let logsDateAndTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .gregorian
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.timeZone = .current
        
        return formatter
    }()
    
    /// Return `self` as a date and time string with a `yyyy.MM.dd HH:mm:ss.SSS` format. E.g. `2019-10-15 16:16:40.723`.
    /// Useful for logs.
    var asLogsDateAndTimeString: String {
        Self.logsDateAndTimeFormatter.string(from: self)
    }
    
    /// Simplification of getting string from date
    func getString(dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short, doesRelativeDateFormatting: Bool = true) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
        
        return formatter.string(from: self)
    }
}
