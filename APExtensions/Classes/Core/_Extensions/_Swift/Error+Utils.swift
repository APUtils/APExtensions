//
//  Error+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/28/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension Error {
    
    /// Returns `self` as `NSError`
    var asNSError: NSError {
        self as NSError
    }
    
    /// Checks if cancelled error
    var isCancelledError: Bool {
        guard _domain == NSURLErrorDomain else { return false }
        return _code == NSURLErrorCancelled
    }
    
    /// Checks if error is related to connection problems. Usual flow is to retry on those errors.
    var isConnectionError: Bool {
        guard _domain == NSURLErrorDomain else { return false }
        
        return _code == NSURLErrorNotConnectedToInternet
            || _code == NSURLErrorCannotFindHost
            || _code == NSURLErrorCannotConnectToHost
            || _code == NSURLErrorInternationalRoamingOff
            || _code == NSURLErrorNetworkConnectionLost
            || _code == NSURLErrorDNSLookupFailed
            || _code == NSURLErrorTimedOut
    }
    
    var coreErrorCode: Int {
        coreError._code
    }
    
    /// Gets the first error from underlying or `self` and casts it to `NSError`
    var coreNSError: NSError {
        coreError as NSError
    }
    
    /// Gets the first error from underlying or `self`
    var coreError: Error {
        var coreError: Error = self
        while let underlyingError = coreError.underlyingError {
            coreError = underlyingError
        }
        
        return coreError
    }
    
    /// Example: `SKErrorDomain 0 | ASDErrorDomain 500 | AMSErrorDomain 305`
    var segmentationString: String {
        var segmentationStringComponents: [String] = ["\(_domain) \(_code)"]
        var coreError: Error = self
        while let underlyingError = coreError.underlyingError {
            coreError = underlyingError
            segmentationStringComponents.append("\(underlyingError._domain) \(underlyingError._code)")
        }
        
        return segmentationStringComponents.joined(separator: " | ")
    }
    
    var underlyingNSError: NSError? {
        userInfo?[NSUnderlyingErrorKey] as? NSError
    }
    
    var underlyingError: Error? {
        userInfo?[NSUnderlyingErrorKey] as? Error
    }
    
    var userInfo: [AnyHashable: Any]? {
        _userInfo as? [AnyHashable: Any]
    }
}
