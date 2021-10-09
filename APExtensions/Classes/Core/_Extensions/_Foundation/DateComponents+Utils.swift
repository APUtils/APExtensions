//
//  DateComponents+Utils.swift
//  APExtensions-example
//
//  Created by Anton Plebanovich on 1/6/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension DateComponents {
    
    /// Makes all components negative to the current ones.
    var negative: DateComponents {
        DateComponents(calendar: calendar,
                       timeZone: timeZone,
                       era: era?.negative,
                       year: year?.negative,
                       month: month?.negative,
                       day: day?.negative,
                       hour: hour?.negative,
                       minute: minute?.negative,
                       second: second?.negative,
                       nanosecond: nanosecond?.negative,
                       weekday: weekday?.negative,
                       weekdayOrdinal: weekdayOrdinal?.negative,
                       quarter: quarter?.negative,
                       weekOfMonth: weekOfMonth?.negative,
                       weekOfYear: weekOfYear?.negative,
                       yearForWeekOfYear: yearForWeekOfYear?.negative)
    }
    
    /// Initializes date components with provided `tiveInterval` and `components`.
    /// Uses day, hour, minute, second, nanosecond components by default.
    init(timeInterval: TimeInterval, components: Set<Calendar.Component> = [.day, .hour, .minute, .second, .nanosecond]) {
        let calendar = Calendar(identifier: .gregorian)
        let date1 = Date()
        let date2 = Date(timeInterval: timeInterval, since: date1)
        self = calendar.dateComponents(components, from: date1, to: date2)
    }
}
