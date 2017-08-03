//
//  APExtensions.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 07/10/2017.
//  Copyright (c) 2017 Anton Plebanovich. All rights reserved.
//

import Foundation


/// Initialization helper class. Ignore it.
public class APExtensions: NSObject {
    
    //-----------------------------------------------------------------------------
    // MARK: - Public Class Properties
    //-----------------------------------------------------------------------------
    
    /// Initialization helper method. Ignore it.
    public static func prepare() {
        _ = setupOnce
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Private Class Properties
    //-----------------------------------------------------------------------------
    
    private static var setupOnce: () = {
        let setupOnes: [SetupOnce.Type] = allSetupOnces()
        setupOnes.forEach({ _ = $0.setupOnce })
    }()
    
    //-----------------------------------------------------------------------------
    // MARK: - Private Class Methods
    //-----------------------------------------------------------------------------
    
    private static func allSetupOnces() -> [SetupOnce.Type] {
        let expectedClassCount = objc_getClassList(nil, 0)
        let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
        let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(allClasses)
        let actualClassCount = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
        
        var classes = [SetupOnce.Type]()
        for i in 0 ..< actualClassCount {
            if let currentClass: AnyClass = allClasses[Int(i)], class_conformsToProtocol(currentClass, SetupOnce.self), let setupOne = currentClass as? SetupOnce.Type {
                classes.append(setupOne)
            }
        }
        
        allClasses.deallocate(capacity: Int(expectedClassCount))
        
        return classes
    }
}
