//
//  ViewController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 07/11/2017.
//  Copyright (c) 2017 Anton Plebanovich. All rights reserved.
//

import UIKit
import APExtensions


class ViewController: UIViewController {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private var uiTestsLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var debugLabel: UILabel!
    
    // ******************************* MARK: - Private Properties

    // ******************************* MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////////////////////////////////////////////////////////
        // Do not remove. UI tests will fail.
        fallbackToUITests()
        ////////////////////////////////////////////////////////////
        
        let attributedText = NSMutableAttributedString(string: "Debug Strikethrough Text")
        attributedText.setStrikethrough(text: "g Strikethrough T")
        debugLabel.attributedText = attributedText
        
        print(c.homeButtonHeight)
        
//        doOnce(key: "viewDidLoad") {
//            print("asd")
//        }
//        doOnce(key: "viewDidLoad") {
//            print("asd")
//        }
        
//        scrollView.addRefreshControl { control in
//            g_asyncMain(1) {
//                control.endRefreshing()
//            }
//        }
        
//        print([1,2,3,4,5,6,7,8,9].splittedArray(splitSize: 2))
        
//        view.showActivityIndicator()
        
//        print(g_getChildrenClasses(of: UIViewController.self))
        
        // Get all classes that conform to SetupOnce protocol
//        let setupOnces = g_getClassesConformToProtocol(SetupOnce.self) as [SetupOnce.Type]
//        print("Classes conform to SetupOnce: \(setupOnces)")
        
//        print(Date().previousWorkDay)
        
        // View configuration
//        let label = UILabel()
//        label.configure(labelState: .shown(text: "label"))
//        label.configure(viewState: .transparent)
        
//        _ = g_documentsDirectoryUrl.smartAppendingPathComponent("/asd")
        
        // Exception handling
//        _ = g_perform {
//            NSException(name: NSExceptionName("name") , reason: "reason", userInfo: ["info": "info"]).raise()
//        }
    }
    
    private func fallbackToUITests() {
        guard c.isRunningUITests else { return }
        uiTestsLabel.isHidden = false
    }
    
    @IBAction private func onDebugTap(_ sender: Any) {
        let vc = UIViewController()
        vc.view.backgroundColor = .black
        presentInPopoverIfNeeded(vc)
    }
}
