//
//  ClassNameProtocol.swift
//  OnTheList
//
//  Created by Anton Plebanovich on 6/8/17.
//  Copyright © 2017 OnTheList. All rights reserved.
//

import Foundation

/// Allows to get class name string
public protocol ClassName {
    @nonobjc static var className: String { get }
}

public extension ClassName {
    @nonobjc static var className: String {
        return String(describing: self)
    }
}

extension NSObject: ClassName {}
