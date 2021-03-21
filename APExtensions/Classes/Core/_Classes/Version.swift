//
//  Version.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 3/21/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation

#if COCOAPODS
import LogsManager
#else
import RoutableLogger
#endif

/// Struct to work with versions.
/// Version example - 0.19.0.123
public struct Version: Codable, Equatable {
    
    // ******************************* MARK: - Public Properties
    
    let major: Int
    let minor: Int
    let patch: Int
    let build: Int?
    let isValid: Bool
    
    var version: String {
        if let build = build {
            return "\(major).\(minor).\(patch).\(build)"
        } else {
            return "\(major).\(minor).\(patch)"
        }
    }
    
    // ******************************* MARK: - Initialization and Setup
    
    init(major: Int, minor: Int, patch: Int, build: Int? = nil) {
        self.major = major
        self.minor = minor
        self.patch = patch
        self.build = build
        isValid = true
    }
    
    /// Instantiates version struct with version string.
    init(_ version: String) {
        let components = version.components(separatedBy: ".")
        
        if let major = components.first?.asInt {
            self.major = major
            isValid = true
        } else {
            major = 0
            isValid = false
            RoutableLogger.logError("Invalid major version", data: ["version": version])
        }
        
        if let minor = components.second?.asInt {
            self.minor = minor
        } else {
            minor = 0
        }
        
        if let patch = components.third?.asInt {
            self.patch = patch
        } else {
            patch = 0
        }
        
        build = components.fourth?.asInt
    }
}


// ******************************* MARK: - ExpressibleByStringLiteral

extension Version: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

// ******************************* MARK: - CustomStringConvertible

extension Version: CustomStringConvertible {
    public var description: String {
        version
    }
}

// ******************************* MARK: - Comparable

extension Version: Comparable {
    public static func < (lhs: Version, rhs: Version) -> Bool {
        if lhs.major < rhs.major {
            return true
        } else if lhs.major > rhs.major {
            return false
        } else if lhs.minor < rhs.minor {
            return true
        } else if lhs.minor > rhs.minor {
            return false
        } else if lhs.patch < rhs.patch {
            return true
        } else if lhs.patch > rhs.patch {
            return false
        } else {
            return lhs.build ?? 0 < rhs.build ?? 0
        }
    }
}
