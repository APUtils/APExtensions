//
//  SingletonManager.swift
//  Elevate
//
//  Created by Anton Plebanovich on 2/28/18.
//  Copyright © 2018 Anton Plebanovich. All rights reserved.
//

import Foundation


/// Same as Manager but with singleton class property
public protocol SingletonManager: Manager {
    /// Manager singleton
    static var shared: Self { get }
}
