//
//  Bool+Utils.swift
//  APExtensions-example
//
//  Created by Anton Plebanovich on 3/21/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension Bool {
    
    /// Returns "with animations" for `true` and "without animations" for `false`
    var asAnimatedString: String {
        self ? "with animations" : "without animations"
    }
    
    /// Returns "enabled" for `true` and "disabled" for `false`.
    var asEnabledString: String {
        self ? "enabled" : "disabled"
    }
    
    /// Returns "successfully finished" for `true` and "was not finished" for `false`.
    var asFinishedString: String {
        self ? "successfully finished" : "was not finished"
    }
    
    /// Returns "forcefully" for `true` and "without force" for `false`.
    var asForceString: String {
        self ? "forcefully" : "without force"
    }
    
    /// Returns "paused" for `true` and "working" for `false`.
    var asPausedString: String {
        self ? "paused" : "working"
    }
    
    /// Returns "true" for `true` and "false" for `false`.
    var asString: String {
        self ? "true" : "false"
    }
}
