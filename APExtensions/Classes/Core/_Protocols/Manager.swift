//
//  Manager.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 7/18/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//


/// Simplifies Managers start and reset routine. All managers could be then started/reseted on apropriate point in app, e.g. on user login/logout.
///
/// To get all Managers in some place (e.g. ApplicationManager) you could use following construction:
///
///      private var managers: [Manager.Type] = {
///          return g_getClassesConformToProtocol(Manager.self)
///      }()
public protocol Manager: class, ClassName {
    /// Start manager. Usually on app start or user login.
    static func start()
    
    /// Reset manager state. Common patter is to clean userDefaults/database manager records and reassign shared variable. Usually on user logout.
    static func reset()
}
