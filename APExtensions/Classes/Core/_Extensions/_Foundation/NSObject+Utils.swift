//
//  NSObject+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 4/24/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Do Once

private var c_doOnceStorageAssociationKey = 0

public extension NSObject {
    private var doOnceStorage: Set<Int>? {
        get {
            return objc_getAssociatedObject(self, &c_doOnceStorageAssociationKey) as? Set<Int>
        }
        set {
            objc_setAssociatedObject(self, &c_doOnceStorageAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Performs action for a key once only.
    func doOnce(key: Int = #line, action: () -> Void) {
        var shouldPerformAction = false
        g.synchronized(self) {
            var doOnceStorage = self.doOnceStorage ?? []
            guard !doOnceStorage.contains(key) else { return }
            
            doOnceStorage.insert(key)
            self.doOnceStorage = doOnceStorage
            shouldPerformAction = true
        }
        
        guard shouldPerformAction else { return }
        
        action()
    }
}
