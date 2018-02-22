//
//  BecomeFirstResponderViewController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/22/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

import APExtensions


final class BecomeFirstResponderViewController: UIViewController, InstantiatableFromStoryboard {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private weak var textField: UITextField!
    
    // ******************************* MARK: - Private Properties
    
    // ******************************* MARK: - Initialization and Setup
    
    override func viewDidLoad() {
        setup()
        
        super.viewDidLoad()
    }
    
    private func setup() {
        
    }
    
    // ******************************* MARK: - Configuration
    
    private func configure() {
        textField.becomeFirstResponderWhenPossible = true
    }
    
    // ******************************* MARK: - UIViewController Overrides

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configure()
    }
    
    // ******************************* MARK: - Actions
    
    // ******************************* MARK: - Notifications
}
