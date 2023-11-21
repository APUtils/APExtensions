//
//  DispatchQueue+Extension.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 24.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Dispatch
import RoutableLogger

// ******************************* MARK: - Perform

private var c_keyAssociationKey = 0

public extension DispatchQueue {
    
    private var key: DispatchSpecificKey<Void> {
        get {
            if let key = objc_getAssociatedObject(self, &c_keyAssociationKey) as? DispatchSpecificKey<Void> {
                return key
            } else {
                let key = DispatchSpecificKey<Void>()
                setSpecific(key: key, value: ())
                objc_setAssociatedObject(self, &c_keyAssociationKey, key, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return key
            }
        }
    }
    
    /// Performs `work` on `self` asynchronously in not already on `self`.
    /// Otherwise, just performs `work`.
    func performAsyncIfNeeded(execute work: @escaping () -> Void) {
        if DispatchQueue.getSpecific(key: key) != nil {
            work()
        } else {
            async { work() }
        }
    }
    
    /// Performs `work` on `self` synchronously. Just performs `work` if already on `self`.
    func performSyncIfNeeded<T>(execute work: () throws -> T) rethrows -> T {
        if DispatchQueue.getSpecific(key: key) != nil {
            return try work()
        } else {
            return try sync { try work() }
        }
    }
    
    /// Performs `work` on `self` asynchronously if not isRunningUnitTests.
    /// Otherwise, just performs `work`.
    func performAsyncIfNotRunningUnitTests(execute work: @escaping () -> Void) {
        if ProcessInfo._isRunningUnitTests {
            work()
        } else {
            async { work() }
        }
    }
}

// ******************************* MARK: - Main

public extension DispatchQueue {
    
    /// Returns `nil` if queue is `main`.
    /// Mostly used for unit tests optimization to allow sync Realm notifications delivery.
    var nonMain: DispatchQueue? {
        if self == DispatchQueue.main {
            return nil
        } else {
            return self
        }
    }
    
    fileprivate static let mainQueueKey: DispatchSpecificKey<Void> = {
        let mainQueueKey = DispatchSpecificKey<Void>()
        main.setSpecific(key: mainQueueKey, value: ())
        
        return mainQueueKey
    }()
    
    /// Returns `true` if we are executing on the main queue or `false` ortherwise.
    static var isMainQueue: Bool {
        getSpecific(key: mainQueueKey) != nil
    }
}

// ******************************* MARK: - Assertion

public extension DispatchQueue {
    
    /// Reports error if thread isn't main and throws an exception in DEBUG builds.
    static func assertMainThread(
        hint: @autoclosure () -> String = "",
        file: StaticString = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        
        if Thread.isMainThread { return }
        
        lazy var message = "Main thread assertion failed with '\(hint())' hint"
        logAssertionFailure(message)
        assertionFailure(message, file: file, line: line)
    }
    
    /// Reports error if queue isn't main and throws an exception in DEBUG builds.
    static func assertMainQueue(
        hint: @autoclosure () -> String = "",
        file: StaticString = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        
        if DispatchQueue.isMainQueue { return }
        
        lazy var message = "Main queue assertion failed with '\(hint())' hint"
        logAssertionFailure(message)
        assertionFailure(message, file: file, line: line)
    }
    
    /// Reports error if executes on a different queue and throws an exception in DEBUG builds.
    /// - note: You must preventively assign non-nil value for a `key` you are passing.
    static func assertQueue<T>(
        key: DispatchSpecificKey<T>,
        hint: @autoclosure () -> String = "",
        file: StaticString = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        
        if DispatchQueue.getSpecific(key: key) != nil { return }
        
        lazy var message = "Queue assertion failed with '\(hint())' hint"
        logAssertionFailure(message)
        assertionFailure(message, file: file, line: line)
    }
    
    private static func logAssertionFailure(
        _ message: @autoclosure () -> String,
        file: StaticString = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        RoutableLogger.logErrorOnce(message(),
                                    data: [
                                        "thread": Thread.current,
                                        "queue": String(cString: __dispatch_queue_get_label(nil), encoding: .utf8),
                                    ],
                                    file: file._toString(),
                                    function: function,
                                    line: line)
    }
}

// ******************************* MARK: - Private Extensions

fileprivate extension StaticString {
    
    /// Transforms static string to a `String`.
    func _toString() -> String {
        withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}

fileprivate extension ProcessInfo {
    
    /// Returns `true` if the app is running unit tests and `false` otherwise.
    static let _isRunningUnitTests: Bool = processInfo
        .environment
        .keys
        .contains("XCTestConfigurationFilePath")
}
