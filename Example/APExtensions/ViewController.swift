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

    //-----------------------------------------------------------------------------
    // MARK: - UIViewController Overrides
    //-----------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        g_sharedNotificationCenter.startDayNotifications()
    }
}
