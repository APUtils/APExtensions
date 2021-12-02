//
//  DispatchQueue+Extension.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 24.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Dispatch

private var c_keyAssociationKey = 0

public extension DispatchQueue {
    
    private var key: DispatchSpecificKey<Void> {
        get {
            if let key = objc_getAssociatedObject(self, &c_keyAssociationKey) as? DispatchSpecificKey<Void> {
                return key
            } else {
                let key = DispatchSpecificKey<Void>()
                setSpecific(key: key, value: ())
                objc_setAssociatedObject(self, &c_keyAssociationKey, key, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return key
            }
        }
        set {
            objc_setAssociatedObject(self, &c_keyAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Performs `work` on `self` synchronously. Just performs `work` if already on a `self.`
    func performSync<T>(execute work: () throws -> T) rethrows -> T {
        if DispatchQueue.getSpecific(key: key) != nil {
            return try work()
        } else {
            return try sync { try work() }
        }
    }
}
