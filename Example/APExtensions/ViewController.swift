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
    
    @IBOutlet private weak var scrollView: UIScrollView!

    // ******************************* MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    @IBAction private func onDebugTap(_ sender: Any) {
        
    }
}
