//
//  Definitions.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/5/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Typealiases

/// Closure that takes Void and returns Void.
public typealias SimpleClosure = () -> Void

/// Closure that takes Bool and returns Void.
public typealias SuccessClosure = (_ success: Bool) -> Void

/// Closure that takes Bool and returns Void.
public typealias ErrorClosure = (_ error: Error?) -> Void

// ******************************* MARK: - Error

/// Error stub to use for simplification
public struct GeneralError: Error { public init() {} }

/// Error with message string used as error description
public struct StringError: LocalizedError {
    private let message: String
    public init(message: String) { self.message = message }
    
    // LocalizedError
    public var errorDescription: String? { message }
}
