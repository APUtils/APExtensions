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
    private var doOnceStorage: [String]? {
        get {
            return objc_getAssociatedObject(self, &c_doOnceStorageAssociationKey) as? [String]
        }
        set {
            objc_setAssociatedObject(self, &c_doOnceStorageAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func doOnce(key: String, action: () -> Void) {
        var shouldPerformAction = false
        g.synchronized(self) {
            var doOnceStorage = self.doOnceStorage ?? []
            guard !doOnceStorage.contains(key) else { return }
            
            doOnceStorage.append(key)
            self.doOnceStorage = doOnceStorage
            shouldPerformAction = true
        }
        
        guard shouldPerformAction else { return }
        
        action()
    }
}
