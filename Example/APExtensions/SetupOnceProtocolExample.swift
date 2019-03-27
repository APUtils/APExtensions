//
//  SetupOnceProtocolExample.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/15/17.
//  Copyright © 2019 Anton Plebanovich All rights reserved.
//

import Foundation
import APExtensions


class SetupOnceProtocolExample {}

// ******************************* MARK: - SetupOnce

extension SetupOnceProtocolExample: SetupOnce {
    // [NSObject load] for Swift
    static var setupOnce: Int {
        print("SetupOnce triggered")
        
        return 0
    }
}
