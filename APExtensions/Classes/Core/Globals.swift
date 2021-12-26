//
//  Globals.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/5/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation
import MessageUI
import RoutableLogger

/// You may override any open property or function and set you own class here.
/// The other option is to declare your own global variable with extended functionality.
public var g: Globals = Globals()

open class Globals {
    
    // ******************************* MARK: - Initialization and Setup
    
    public init() {}
    
    // ******************************* MARK: - Comparison
    
    // TODO: Should be compared by pixel equality
    /// Compares two `CGSize`s with 0.0001 tolerance
    open func isCGSizesEqual(first: CGSize, second: CGSize) -> Bool {
        if abs(first.width - second.width) < 0.0001 && abs(first.height - second.height) < 0.0001 {
            return true
        } else {
            return false
        }
    }
    
    // ******************************* MARK: - Global Vars
    
    /// Shared application
    open var sharedApplication: UIApplication {
        return UIApplication.shared
    }
    
    /// Default file manager
    open var sharedFileManager: FileManager {
        return FileManager.default
    }
    
    /// Default notification center
    open var sharedNotificationCenter: NotificationCenter {
        return NotificationCenter.default
    }
    
    /// Shared user defaults
    open var sharedUserDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    /// Height of status bar for the application window.
    /// Might be `nil` if there is no application window.
    /// 44 on X devices, 20 on usual.
    @available(iOS 13.0, *)
    open var statusBarHeight: CGFloat? {
        UIApplication.shared
            .delegate?
            .window??
            .windowScene?
            .statusBarManager?
            .statusBarFrame
            .height
    }
    
    /// Tob bars height for the application window.
    /// Might be `nil` if there is no application window.
    @available(iOS 13.0, *)
    open var topBarsHeight: CGFloat? {
        guard let statusBarHeight = statusBarHeight else { return nil }
        return statusBarHeight + c.navigationBarHeight
    }
    
    /// Application's key window
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "Should not be used for applications that support multiple scenes as it returns a key window across all connected scenes")
    open var keyWindow: UIWindow? {
        return sharedApplication.keyWindow
    }
    
    /// Application's window. Crashes if nil.
    open var appWindow: UIWindow {
        return sharedApplication.delegate!.window!!
    }
    
    /// Is application in `active` state?
    open var isAppActive: Bool {
        return sharedApplication.applicationState == .active
    }
    
    // ******************************* MARK: - Swift Exception Handling
    
    open func perform(_ closure: SimpleClosure) -> NSException? {
        return APUtils.perform(closure)
    }
    
    // ******************************* MARK: - Unwrap
    
    /// Removes nested optionals until only one left
    open func unwrap(_ _any: Any?) -> Any? {
        guard let any = _any else { return _any }
        
        // Check if Any actually is Any?
        if let optionalAny = any as? _Optional {
            return unwrap(optionalAny._value)
        } else {
            return any
        }
    }
    
    // ******************************* MARK: - Top Controller
    
    /// Current top most view controller
    public var topViewController: UIViewController? {
        return topViewController()
    }
    
    /// Returns top view controller from `base` controller.
    /// - note: In case you are using custom container controllers in your application this method won't be able to process them.
    /// - parameters:
    ///   - base: Base controller from which to start. If not specified or nil then application delegate window's rootViewController will be used.
    ///   - shouldCheckPresented: Should it check for presented controllers?
    open func topViewController(base: UIViewController? = nil, shouldCheckPresented: Bool = true) -> UIViewController? {
        let base = base ?? sharedApplication.delegate?.window??.rootViewController
        
        if let navigationVc = base as? UINavigationController {
            return topViewController(base: navigationVc.topViewController, shouldCheckPresented: shouldCheckPresented)
        }
        
        if let tabBarVc = base as? UITabBarController {
            if let selected = tabBarVc.selectedViewController {
                return topViewController(base: selected, shouldCheckPresented: shouldCheckPresented)
            }
        }
        
        if shouldCheckPresented, let presented = base?.presentedViewController {
            return topViewController(base: presented, shouldCheckPresented: shouldCheckPresented)
        }
        
        return base
    }
    
    /// Returns top most view controller that handles status bar style.
    /// This property might be more accurate than `topViewController` if custom container view controllers configured properly to return their top most controllers for status bar appearance.
    public var statusBarStyleTopViewController: UIViewController? {
        var currentVc = topViewController
        while let newTopVc = currentVc?.childForStatusBarStyle {
            currentVc = topViewController(base: newTopVc)
        }
        
        return currentVc
    }
    
    // ******************************* MARK: - Animations
    
    open func animate(animations: @escaping SimpleClosure) {
        animate(animations: animations, completion: nil)
    }
    
    open func animate(_ duration: TimeInterval, animations: @escaping SimpleClosure) {
        animate(duration, animations: animations, completion: nil)
    }
    
    open func animate(_ duration: TimeInterval, options: UIView.AnimationOptions, animations: @escaping SimpleClosure) {
        animate(duration, options: options, animations: animations, completion: nil)
    }
    
    open func animate(_ duration: TimeInterval = 0.3,
                      delay: TimeInterval = 0,
                      options: UIView.AnimationOptions = .beginFromCurrentState,
                      animations: @escaping SimpleClosure,
                      completion: ((Bool) -> ())? = nil) {
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: animations, completion: completion)
    }
    
    // ******************************* MARK: - Dispatch
    
    /// Executes a closure in a default queue after requested seconds. Uses GCD.
    /// - parameters:
    ///   - delay: number of seconds to delay
    ///   - closure: the closure to be executed
    open func asyncBg(_ delay: TimeInterval = 0, closure: @escaping SimpleClosure) {
        let delayTime: DispatchTime = .now() + delay
        DispatchQueue.global(qos: .default).asyncAfter(deadline: delayTime, execute: {
            closure()
        })
    }
    
    /// Executes a closure if already in background or dispatch asyn in background. Uses GCD.
    /// - parameters:
    ///   - closure: the closure to be executed
    open func performInBackground(_ closure: @escaping SimpleClosure) {
        if Thread.isMainThread {
            DispatchQueue.global(qos: .default).async {
                closure()
            }
        } else {
            closure()
        }
    }
    
    /// Executes a closure in the main queue after requested seconds asynchronously. Uses GCD.
    /// - parameters:
    ///   - delay: number of seconds to delay
    ///   - closure: the closure to be executed
    open func asyncMain(_ delay: TimeInterval = 0, closure: @escaping SimpleClosure) {
        let delayTime: DispatchTime = .now() + delay
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            closure()
        }
    }
    
    /// Executes a closure if already in main or dispatch asyn in main. Uses GCD.
    /// - parameters:
    ///   - closure: the closure to be executed
    open func performInMain(_ closure: @escaping SimpleClosure) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async { closure() }
        }
    }
    
    // ******************************* MARK: - Thread Safety
    
    /// Helper function that mimics objc @synchronized(self) {...} behaviour and syntax
    open func synchronized(_ lock: Any, closure: () throws -> Void) rethrows {
        objc_sync_enter(lock); defer { objc_sync_exit(lock) }
        
        try closure()
    }
    
    // ******************************* MARK: - Alerts
    
    /// Shows error alert with title, message, action title, cancel title and handler
    /// - parameter title: Alert title. Default is `nil` - no title.
    /// - parameter message: Alert message. Default is `nil` - no message.
    /// - parameter actionTitle: Action button title. Default is `Dismiss`.
    /// - parameter style: Action button style. Default is `.cancel`.
    /// - parameter cancelTitle: Cancel button title. Default is `nil` - no cancel button.
    /// - parameter onCancel: Cancel button click closure. Default is `nil` - no action.
    /// - parameter handler: Action button click closure. Default is `nil` - no action.
    open func showErrorAlert(title: String? = nil,
                             message: String? = nil,
                             actionTitle: String = "Dismiss",
                             style: UIAlertAction.Style = .cancel,
                             cancelTitle: String? = nil,
                             onCancel: (() -> Void)? = nil,
                             handler: (() -> Void)? = nil) {
        
        performInMain {
            let alertVC = AlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: actionTitle, style: style, handler: { _ in handler?() }))
            if let cancelTitle = cancelTitle {
                alertVC.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { _ in onCancel?() }))
            }
            
            alertVC.present(animated: true)
        }
    }
    
    /// Shows enter text alert with title and message
    /// - parameter title: Alert title
    /// - parameter message: Alert message
    /// - parameter confirmTitle: Confirm button title. Default is `Confirm`.
    /// - parameter cancelTitle: Cancel button title. Default is `Cancel`.
    /// - parameter textFieldConfiguration: Text field configuration closure.
    /// - parameter onCancel: Cancel button click closure. Default is `nil` - no action.
    /// - parameter completion: Closure that takes user entered text as parameter
    open func showEnterTextAlert(title: String? = nil,
                                 message: String? = nil,
                                 confirmTitle: String = "Confirm",
                                 cancelTitle: String = "Cancel",
                                 textFieldConfiguration: ((UITextField) -> Void)? = nil,
                                 onCancel: (() -> Void)? = nil,
                                 completion: @escaping (_ text: String) -> ()) {
        
        performInMain {
            let alertVC = AlertController(title: title, message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: confirmTitle, style: .cancel) { action in
                let text = alertVC.textFields?.first?.text ?? ""
                completion(text)
            }
            let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: { _ in onCancel?() })
            
            alertVC.addTextField { (textField) in
                textFieldConfiguration?(textField)
            }
            
            alertVC.addAction(confirmAction)
            alertVC.addAction(cancelAction)
            
            alertVC.present(animated: true)
        }
    }
    
    /// Shows picker alert with title and message.
    /// - parameter title: Alert title
    /// - parameter buttons: Button titles
    /// - parameter buttonsStyles: Button styles
    /// - parameter enabledButtons: Enabled buttons
    /// - parameter cancelTitle: Cancel button title. Default is `Cancel`.
    /// - parameter onCancel: Cancel button click closure. Default is `nil` - no action.
    /// - parameter completion: Closure that takes button title and button index as its parameters
    open func showPickerAlert(title: String? = nil,
                              message: String? = nil,
                              buttons: [String],
                              buttonsStyles: [UIAlertAction.Style]? = nil,
                              enabledButtons: [Bool]? = nil,
                              cancelTitle: String = "Cancel",
                              onCancel: (() -> Void)? = nil,
                              completion: @escaping ((String, Int) -> ())) {
        
        performInMain {
            if let buttonsStyles = buttonsStyles, buttons.count != buttonsStyles.count {
                RoutableLogger.logError("Invalid buttonsStyles count", data: ["title": title, "message": message, "buttons": buttons, "buttonsStyles": buttonsStyles, "buttonsCount": buttons.count, "buttonsStylesCount": buttonsStyles.count, "enabledButtons": enabledButtons, "enabledButtonsCount": enabledButtons?.count])
                return
            }
            
            if let enabledButtons = enabledButtons, buttons.count != enabledButtons.count {
                RoutableLogger.logError("Invalid enabledButtons count", data: ["title": title, "message": message, "buttons": buttons, "buttonsStyles": buttonsStyles, "buttonsCount": buttons.count, "buttonsStylesCount": buttonsStyles?.count, "enabledButtons": enabledButtons, "enabledButtonsCount": enabledButtons.count])
                return
            }
            
            let vc = AlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: { _ in onCancel?() })
            vc.addAction(cancel)
            
            for (index, button) in buttons.enumerated() {
                let buttonStyle = buttonsStyles?[index] ?? .default
                let action = UIAlertAction(title: button, style: buttonStyle, handler: { _ in
                    completion(button, index)
                })
                
                if let enabledButtons = enabledButtons, enabledButtons.count == buttons.count {
                    action.isEnabled = enabledButtons[index]
                }
                
                vc.addAction(action)
            }
            
            vc.present(animated: true)
        }
    }
    
    // ******************************* MARK: - Email
    
    public typealias EmailAttachment = (data: Data, mimeType: String, fileName: String)
    
    /// Tries to send email with MFMailComposeViewController first. If can't uses mailto: url scheme.
    /// - parameter to: Addressee's email
    /// - parameter title: Optional email title
    /// - parameter body: Optional email body
    open func sendEmail(to: String, title: String? = nil, body: String? = nil) {
        if !sendEmailUsingMailComposer(to: to, title: title, body: body, attachments: []) {
            sendEmailUsingMailto(to: to, title: title, body: body)
        }
    }
    
    /// Sends email with MFMailComposeViewController. Won't do anything if `MFMailComposeViewController.canSendMail()` returns false.
    /// - parameter to: Addressee's email
    /// - parameter title: Optional email title
    /// - parameter body: Optional email body
    /// - parameter attachments: Typles with data, mime type and file name.
    /// - returns: false if can not send email
    open func sendEmailUsingMailComposer(to: String, title: String? = nil, body: String? = nil, attachments: [EmailAttachment] = []) -> Bool {
        guard let vc = MFMailComposeViewController.create(to: [to]) else { return false }
        
        vc.setSubject(title ?? "")
        vc.setMessageBody(body ?? "", isHTML: false)
        attachments.forEach({
            vc.addAttachmentData($0.0, mimeType: $0.1, fileName: $0.2)
        })
        
        sharedApplication.delegate?.window??.rootViewController?.present(vc, animated: true, completion: nil)
        
        return true
    }
    
    /// Sends email using mailto: url scheme. Won't do anything if URL can not be composed.
    /// - parameter to: Addressee's email
    /// - parameter title: Optional email title
    /// - parameter body: Optional email body
    open func sendEmailUsingMailto(to: String, title: String? = nil, body: String? = nil) {
        guard var urlComponents = URLComponents(string: "mailto:\(to)") else { return }
        
        if let title = title {
            let item = URLQueryItem(name: "subject", value: title)
            urlComponents.addQueryItem(item)
        }
        
        if let body = body {
            let item = URLQueryItem(name: "body", value: body)
            urlComponents.addQueryItem(item)
        }
        
        guard let url = urlComponents.url else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    // ******************************* MARK: - Network Activity
    
    private var networkActivityCounter = 0
    
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "Provide a custom network activity UI in your app if desired.")
    open func showNetworkActivity() {
        networkActivityCounter = max(0, networkActivityCounter)
        networkActivityCounter += 1
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "Provide a custom network activity UI in your app if desired.")
    open func hideNetworkActivity() {
        networkActivityCounter -= 1
        
        if networkActivityCounter <= 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    // ******************************* MARK: - Swizzle
    
    /// Swizzles meta class methods
    /// - Parameters:
    ///   - class: Class or meta class.
    open func swizzleClassMethods(class: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let metaClass: AnyClass
        if class_isMetaClass(`class`) {
            metaClass = `class`
            
        } else {
            // Getting meta class of class
            let className = "\(`class`)"
            guard let _metaClass = objc_getMetaClass(className) as? AnyClass else {
                RoutableLogger.logError("Unable to get metaclass from class", data: ["class": `class`, "originalSelector": originalSelector, "swizzledSelector": swizzledSelector])
                return
            }
            
            metaClass = _metaClass
        }
        
        guard class_isMetaClass(metaClass) else {
            RoutableLogger.logError("Class is not meta class", data: ["class": `class`, "metaClass": metaClass, "originalSelector": originalSelector, "swizzledSelector": swizzledSelector])
            return
        }
        
        guard class_respondsToSelector(metaClass, originalSelector) else {
            RoutableLogger.logError("Meta class does not respond to original selector", data: ["class": `class`, "metaClass": metaClass, "originalSelector": originalSelector, "swizzledSelector": swizzledSelector])
            return
        }
        
        guard class_respondsToSelector(metaClass, swizzledSelector) else {
            RoutableLogger.logError("Meta class does not respond to swizzled selector", data: ["class": `class`, "metaClass": metaClass, "originalSelector": originalSelector, "swizzledSelector": swizzledSelector])
            return
        }
        
        let originalMethod = class_getClassMethod(metaClass, originalSelector)!
        let swizzledMethod = class_getClassMethod(metaClass, swizzledSelector)!
        
        swizzleMethods(class: metaClass, originalSelector: originalSelector, originalMethod: originalMethod, swizzledSelector: swizzledSelector, swizzledMethod: swizzledMethod)
    }
    
    /// Swizzles class methods
    open func swizzleMethods(class: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard !class_isMetaClass(`class`) else {
            RoutableLogger.logError("Class is meta class", data: ["class": `class`, "originalSelector": originalSelector, "swizzledSelector": swizzledSelector])
            return
        }
        
        guard class_respondsToSelector(`class`, originalSelector) else {
            RoutableLogger.logError("Class does not respond to original selector", data: ["class": `class`, "originalSelector": originalSelector, "swizzledSelector": swizzledSelector])
            return
        }
        
        guard class_respondsToSelector(`class`, swizzledSelector) else {
            RoutableLogger.logError("Class does not respond to swizzled selector", data: ["class": `class`, "originalSelector": originalSelector, "swizzledSelector": swizzledSelector])
            return
        }
        
        let originalMethod = class_getInstanceMethod(`class`, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(`class`, swizzledSelector)!
        
        swizzleMethods(class: `class`, originalSelector: originalSelector, originalMethod: originalMethod, swizzledSelector: swizzledSelector, swizzledMethod: swizzledMethod)
    }
    
    private func swizzleMethods(class: AnyClass, originalSelector: Selector, originalMethod: Method, swizzledSelector: Selector, swizzledMethod: Method) {
        let didAddMethod = class_addMethod(`class`, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(`class`, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    // ******************************* MARK: - Erase
    
    open func eraseAllData() {
        eraseUserDefaults()
        eraseKeychain()
        eraseFiles()
    }
    
    open func eraseUserDefaults() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain ?? "")
    }
    
    open func eraseKeychain() {
        let secItemClasses = [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity
        ]
        
        secItemClasses.forEach { secItemClass in
            let spec = [kSecClass: secItemClass]
            SecItemDelete(spec as CFDictionary)
        }
    }
    
    open func eraseFiles() {
        var directoriesToErase: [URL] = []
        
        if let caches = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            directoriesToErase.append(caches)
        }
        
        if let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            directoriesToErase.append(documents)
        }
        
        directoriesToErase.append(URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true))
        
        if let application = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first {
            directoriesToErase.append(application)
        }
        
        if let library = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first {
            
            // Cookies
            let cookies = library.appendingPathComponent("Cookies/")
            directoriesToErase.append(cookies)
            
            // User defaults
            let userDefaults = library.appendingPathComponent("Preferences/")
            directoriesToErase.append(userDefaults)
            
            // Private Documents
            let privateDocuments = library.appendingPathComponent("PrivateDocuments/")
            directoriesToErase.append(privateDocuments)
            
            do {
                let urls = try FileManager.default.contentsOfDirectory(
                    at: library,
                    includingPropertiesForKeys: nil,
                    options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
                
                for url in urls {
                    var isDirectory: Bool
                    do {
                        isDirectory = try url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory == true
                    } catch {
                        RoutableLogger.logError("Unable to check item type", error: error, data: ["url": url])
                        continue
                    }
                    
                    if isDirectory {
                        continue
                    }
                    
                    do {
                        try FileManager.default.removeItem(at: url)
                    } catch {
                        RoutableLogger.logError("Unable to check item type", error: error, data: ["url": url])
                    }
                }
                
            } catch {
                RoutableLogger.logError("Unable to get contents of library directory to erase files", error: error, data: ["library": library])
            }
            
        }
        
        for directory in directoriesToErase {
            if !FileManager.default.fileExists(atPath: directory.path) {
                continue
            }
            
            let urls: [URL]
            do {
                urls = try FileManager.default.contentsOfDirectory(
                    at: directory,
                    includingPropertiesForKeys: nil,
                    options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            } catch {
                RoutableLogger.logError("Unable to get contents of directory to erase files", error: error, data: ["directory": directory])
                continue
            }
            
            for url in urls {
                if url.lastPathComponent == "Snapshots" {
                    continue
                }
                
                // Prevent logs deletion so we can check them later
                if url.lastPathComponent == "LogsManager" {
                    continue
                }
                
                do {
                    try FileManager.default.removeItem(at: url)
                } catch {
                    RoutableLogger.logError("Unable to remove item", error: error, data: ["url": url, "directory": directory])
                }
            }
        }
    }
    
    // ******************************* MARK: - Other Global Functions
    
    /// Returns all classes that conforms to specified protocol. Protocol must be declared with @objc annotation.
    /// Takes 0.003s - 0.02s on 5s device. Example usage:
    ///
    ///     let setupOnes: [SetupOnce.Type] = getClassesConformToProtocol(SetupOnce.self)
    ///     // or
    ///     let setupOnes = getClassesConformToProtocol(SetupOnce.self) as [SetupOnce.Type]
    open func getClassesConformToProtocol<T>(_ protocol: Protocol) -> [T] {
        return APExtensionsLoader.getClassesConform(to: `protocol`).compactMap({ $0 as? T })
    }
    
    /// Returns all child classes for specified class. Not recursively.
    /// Takes 0.015s on 5s device. Example usage:
    ///
    ///     let childClasses = getChildrenClasses(UIViewController.self)
    open func getChildrenClasses<T: AnyObject>(of `class`: T.Type) -> [T.Type] {
        return APExtensionsLoader.getChildClasses(for: `class`).compactMap({ $0 as? T.Type })
    }
    
    open func getMethodsList(object: AnyObject) -> [String]? {
        var mc: UInt32 = 0
        let mcPointer = withUnsafeMutablePointer(to: &mc) { $0 }
        guard let mlist = class_copyMethodList(object_getClass(object), mcPointer) else { return nil }
        
        var methods: [String] = []
        for i in 0...Int(mc) {
            let method = String(format: "Method #%d: %s", arguments: [i, sel_getName(method_getName(mlist[i]))])
            methods.append(method)
        }
        
        return methods
    }
    
    /// Returns string prepresentation of object's pointer
    open func getPointer(_ any: AnyObject) -> String {
        return Unmanaged<AnyObject>.passUnretained(any as AnyObject).toOpaque().debugDescription
    }
    
    open func Translate(_ string: String) -> String {
        return NSLocalizedString(string, comment: "")
    }
    
    /// Opens iOS Settings page for current application
    open func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(settingsURL)
        }
    }
    
    /// - Parameter value: Value to resize.
    /// - returns: Screen resized value.
    ///
    /// Please check [screenResizeCoef](x-source-tag://screenResizeCoef) for more details
    open func screenResize(_ value: CGFloat) -> CGFloat {
        value.screenResized
    }
}

// ******************************* MARK: - Unwrap

/// Helper protocol
private protocol _Optional {
    var _value: Any? { get }
}

extension Optional: _Optional {
    var _value: Any? {
        switch self {
        case .none: return nil
        case .some(_): return self!
        }
    }
}
