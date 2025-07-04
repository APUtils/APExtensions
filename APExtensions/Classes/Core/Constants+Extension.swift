//
//  Constants+Extension.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/5/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

#if SPM
import APExtensionsShared
#endif
import Foundation
import UIKit

public extension Constants {
    
    /// Is running on simulator?
#if targetEnvironment(simulator)
    static let isSimulator: Bool = true
#else
    static let isSimulator: Bool = false
#endif
    
    /// Is it an iPhone device?
    static let isIPhone: Bool = UIDevice.current.userInterfaceIdiom == .phone
    
    /// Screen size
    static let screenSize: CGSize = UIScreen.main.bounds.size
    
    /// Screen scale factor
    static let screenScale: CGFloat = UIScreen.main.scale
    
    /// Screen pixel size
    static let pixelSize: CGFloat = 1 / UIScreen.main.scale
    
    /// User documents directory URL
    static let documentsDirectoryUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    
    /// User temporary directory URL
    static let tempDirectoryUrl: URL = URL(fileURLWithPath: NSTemporaryDirectory())
    
    /// User cache directory URL
    static let cacheDirectoryUrl: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last!
    
    /// Height of status bar. 44 on X devices, 20 on usual.
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "Please use g.statusBarHeight instead")
    static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    
    /// Navigation bar height
    static let navigationBarHeight: CGFloat = 44
    
    /// Top bars height
    @available(iOS, introduced: 2.0, deprecated: 13.0, message: "Please use g.topBarsHeight instead")
    static let topBarsHeight: CGFloat = statusBarHeight + navigationBarHeight
    
    /// Returns the on screen home button height
    static let homeButtonHeight: CGFloat = {
        if #available(iOS 11.0, *) {
            return g.applicationWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }()
}
