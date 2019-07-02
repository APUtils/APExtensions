//
//  Error+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/28/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import Foundation


public extension Error {
    /// Checks if error is related to connection problems. Usual flow is to retry on those errors.
    @available(*, deprecated, renamed: "isConnectionError")
    var isConnectError: Bool {
        return isConnectionError
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
}
