//
//  Bundle+Extension.swift
//  Pods
//
//  Created by Anton Plebanovich on 3/20/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation

#if COCOAPODS
import LogsManager
#else
import RoutableLogger
#endif

// ******************************* MARK: - Resource

public extension Bundle {
    
    func json(forResource resource: String, withExtension extension: String) -> [String: Any]? {
        guard let url = url(forResource: resource, withExtension: `extension`) else {
            logError("Unable to locate a resource in main bundle", data: ["resource": resource, "extension": `extension`])
            return nil
        }
        
        guard let data = Data(safeContentsOf: url) else {
            logError("Unable to get data for a resource", data: ["resource": resource, "extension": `extension`, "url": url])
            return nil
        }
        
        let _json: Any
        do {
            _json = try JSONSerialization.jsonObject(with: data, options: [])
        } catch {
            logError("Unable to serialize resource into JSON",
                     error: error,
                     data: [
                        "resource": resource,
                        "extension": `extension`,
                        "url": url,
                        "data": data.utf8String
                     ])
            
            return nil
        }
        
        guard let json = _json as? [String: Any] else {
            logError("Unable to cast JSON to a Dictionary", data: [
                "resource": resource,
                "extension": `extension`,
                "url": url,
                "json": _json
            ])
            return nil
        }
        
        return json
    }
}

// ******************************* MARK: - Version

public extension Bundle {
    
    /// Example: 3.10.0
    static let appVersionString: String = {
        var version = main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        
        // Removing excessive version components, e.g. '.93'
        var dotComponents = version.components(separatedBy: ".")
        if dotComponents.count > 3 {
            dotComponents.removeLast(dotComponents.count - 3)
            version = dotComponents.joined(separator: ".")
        }
        
        return version
    }()
    
    /// Example:
    /// - major: 3
    /// - minor: 10
    /// - patch: 0
    static let appVersion: Version = { Version(appVersionString) }()
    
    /// Example: 9364
    static let appBuildVersionString: String = { main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown" }()
    
    /// Example: 3.10.0.9364
    static let appFullVersionString: String = { "\(appVersionString).\(appBuildVersionString)" }()
    
    /// Example:
    /// - major: 3
    /// - minor: 10
    /// - patch: 0
    /// - build: 9832
    static let fullAppVersion: Version = { Version(appFullVersionString) }()
}

public extension Bundle {
    /// Struct to work with versions.
    /// Version example - 0.19.0.123
    struct Version: Codable, Equatable {
        
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
                logError("Invalid major version", data: ["version": version])
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
}


// ******************************* MARK: - ExpressibleByStringLiteral

extension Bundle.Version: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

// ******************************* MARK: - CustomStringConvertible

extension Bundle.Version: CustomStringConvertible {
    public var description: String {
        version
    }
}

// ******************************* MARK: - Comparable

extension Bundle.Version: Comparable {
    public static func < (lhs: Bundle.Version, rhs: Bundle.Version) -> Bool {
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
