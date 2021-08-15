//
//  Constants.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/5/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

public enum Constants {
    
    /// Is running on simulator?
    public static let isSimulator: Bool = TARGET_OS_SIMULATOR != 0
    
    /// Is it an iPhone device?
    public static let isIPhone: Bool = UIDevice.current.userInterfaceIdiom == .phone
    
    /// Screen size
    public static let screenSize: CGSize = UIScreen.main.bounds.size
    
    /// Screen scale factor
    public static let screenScale: CGFloat = UIScreen.main.scale
    
    public static let screenResizeCoef: CGFloat = {
        let baseScreenSize: CGFloat = 414 // iPhone 6+
        let currentScreenSize = UIScreen.main.bounds.width
        return currentScreenSize / baseScreenSize
    }()
    
    /// Screen pixel size
    public static let pixelSize: CGFloat = 1 / UIScreen.main.scale
    
    /// User documents directory URL
    public static let documentsDirectoryUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    
    /// User temporary directory URL
    public static let tempDirectoryUrl: URL = URL(fileURLWithPath: NSTemporaryDirectory())
    
    /// User cache directory URL
    public static let cacheDirectoryUrl: URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last!
    
    /// Height of status bar
    public static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    
    /// Navigation bar height
    public static let navigationBarHeight: CGFloat = 44
    
    /// Navigation bar height
    public static let topBarsHeight: CGFloat = statusBarHeight + navigationBarHeight
    
    /// Returns the on screen home button height
    public static let homeButtonHeight: CGFloat = {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }()
}

public let c: Constants.Type = Constants.self
