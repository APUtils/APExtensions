//
//  CGPoint+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/20/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Operations

public extension CGPoint {
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
    
    static func -=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }
}

// ******************************* MARK: - Other

public extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
}
