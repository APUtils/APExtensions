//
//  DateComponents+Utils.swift
//  APExtensions-example
//
//  Created by Anton Plebanovich on 1/6/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension DateComponents {
    
    /// Initializes date components with provided `tiveInterval`.
    /// Uses day, hour, minute, second, nanosecond components.
    init(timeInterval: TimeInterval) {
        let calendar = Calendar(identifier: .gregorian)
        let date1 = Date()
        let date2 = Date(timeInterval: timeInterval, since: date1)
        let components: Set<Calendar.Component> = [.day, .hour, .minute, .second, .nanosecond]
        self = calendar.dateComponents(components, from: date1, to: date2)
    }
}
