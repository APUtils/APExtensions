//
//  ViewController.swift
//  APExtensions-example
//
//  Created by mac-246 on 2/16/18.
//  Copyright © 2018 Anton Plebanovich. All rights reserved.
//

import APExtensions
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Constants.topBarsHeight)
        print(Constants.statusBarHeight)
        print(Constants.homeButtonHeight)
        print(DateComponents(timeInterval: 10000000000.111) )
    }
}
