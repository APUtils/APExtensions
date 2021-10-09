//
//  Bundle+Utils.swift
//  APExtensions
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
            RoutableLogger.logError("Unable to locate a resource in main bundle", data: ["resource": resource, "extension": `extension`])
            return nil
        }
        
        guard let data = Data(safeContentsOf: url) else {
            RoutableLogger.logError("Unable to get data for a resource", data: ["resource": resource, "extension": `extension`, "url": url])
            return nil
        }
        
        let _json: Any
        do {
            _json = try JSONSerialization.jsonObject(with: data, options: [])
        } catch {
            RoutableLogger.logError("Unable to serialize resource into JSON",
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
            RoutableLogger.logError("Unable to cast JSON to a Dictionary", data: [
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

// ******************************* MARK: - Safe

public extension Bundle {
    
    /// Gets data for a resource from bundle and reports error if unable.
    func safeGetData(forResource resource: String, withExtension extension: String) -> Data? {
        guard let url = url(forResource: resource, withExtension: `extension`) else {
            RoutableLogger.logError("Unable to get URL for JSON mock", data: ["resource": resource, "extension": `extension`])
            return Data()
        }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            RoutableLogger.logError("Unable to get contents of file for JSON mock", error: error, data: ["resource": resource, "extension": `extension`, "url": url])
            return Data()
        }
    }
    
    /// Gets string for a resource from bundle and reports error if unable.
    func safeGetString(forResource resource: String, withExtension extension: String) -> String? {
        guard let path = path(forResource: resource, ofType: `extension`) else {
            RoutableLogger.logError("Unable to get path for JSON mock", data: ["resource": resource, "extension": `extension`])
            return nil
        }
        
        do {
            return try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            RoutableLogger.logError("Unable to get contents of file for JSON mock", error: error, data: ["resource": resource, "extension": `extension`, "path": path])
            return nil
        }
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

// ******************************* MARK: - Other

public extension Bundle {
    
    /// Example: com.anton-plebanovich.APExtensions-Example
    static let appID: String = {
        main.infoDictionary?["CFBundleIdentifier"] as? String ?? "unknown"
    }()
}
