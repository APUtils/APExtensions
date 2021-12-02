//
//  Constants+Extension.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/5/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

public extension Constants {
    
    /// Is running on simulator?
    static let isSimulator: Bool = TARGET_OS_SIMULATOR != 0
    
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
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }()
}
