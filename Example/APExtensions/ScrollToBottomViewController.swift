//
//  ScrollToBottomViewController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 11/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import APExtensions


final class ScrollToBottomViewController: UIViewController, InstantiatableFromStoryboard {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // ******************************* MARK: - Private Properties
    
    // ******************************* MARK: - Initialization and Setup
    
    private func setup() {
        
    }
    
    // ******************************* MARK: - Configuration
    
    private func configure() {
        tabBarController?.navigationItem.rightBarButtonItems = navigationItem.rightBarButtonItems
    }
    
    // ******************************* MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        setup()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
    }
    
    // ******************************* MARK: - Actions
    
    @IBAction private func onScrollToBottomTap(_ sender: Any) {
        scrollView.scrollToBottom(animated: true)
    }
    
    // ******************************* MARK: - Notifications
}
