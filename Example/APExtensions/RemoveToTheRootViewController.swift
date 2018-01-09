//
//  RemoveToTheRootViewController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import APExtensions


final class RemoveToTheRootViewController: UIViewController, InstantiatableFromStoryboard {
    
    // ******************************* MARK: - @IBOutlets
    
    // ******************************* MARK: - Private Properties
    
    // ******************************* MARK: - Initialization and Setup
    
    static var storyboardName: String {
        return "Main"
    }
    
    private func setup() {
        
    }
    
    // ******************************* MARK: - Configuration
    
    private func configure() {
        
    }
    
    // ******************************* MARK: - UIViewController Overrides
    
    override func viewDidLoad() {
        setup()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
        
        print("\(g_getPointer(self)) viewWillAppear \(animated)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("\(g_getPointer(self)) viewDidDisappear \(animated)")
    }
    
    // ******************************* MARK: - Actions
    
    @IBAction private func onPresentTap(_ sender: Any) {
        let navigationVc = RemoveToTheRootViewController.createWithNavigationController().0
        present(navigationVc, animated: true, completion: nil)
    }
    
    @IBAction private func onPushTap(_ sender: Any) {
        navigationController?.pushViewController(RemoveToTheRootViewController.create(), animated: true)
    }
    
    @IBAction private func onRemoveToTheRootTap(_ sender: Any) {
        removeToRoot(animated: false) {
            print("Completed")
        }
    }
    
    @IBAction private func onRemoveTap(_ sender: Any) {
        remove(animated: false)
    }
    
    // ******************************* MARK: - Notifications
}
