//
//  TimeZone+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/16/19.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Static time zones

public extension TimeZone {
    /// GMT time zone
    static let gmt: TimeZone = TimeZone(secondsFromGMT: 0)!
}

// ******************************* MARK: - Short Description

public extension TimeZone {
    var shortDescription: String {
        "\(identifier) \(abbreviation().description)"
    }
}
