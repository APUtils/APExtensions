//
//  RemoveToTheRootViewController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/8/18.
//  Copyright © 2019 Anton Plebanovich All rights reserved.
//

import UIKit
import APExtensions


private var g_controllerCount = 0


final class RemoveToTheRootViewController: UIViewController, InstantiatableFromStoryboard {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private weak var numberLabel: UILabel!
    
    // ******************************* MARK: - Private Properties
    
    // ******************************* MARK: - Initialization and Setup
    
    static var storyboardName: String {
        return "Main"
    }
    
    private func setup() {
        numberLabel.text = String(g_controllerCount)
        g_controllerCount += 1
    }
    
    // ******************************* MARK: - Configuration
    
    private func configure() {
        
    }
    
    // ******************************* MARK: - UIViewController Overrides
    
    override var description: String {
        return numberLabel.text!
    }
    
    override func viewDidLoad() {
        setup()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
        
        print("\(numberLabel.text!) viewWillAppear \(animated)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("\(numberLabel.text!) viewDidDisappear \(animated)")
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
        removeToRoot(animated: true) {
            print("Completed")
        }
    }
    
    @IBAction private func onRemoveTap(_ sender: Any) {
        remove(animated: true)
        
//        g_showErrorAlert()
//        ((g_rootViewController as! UINavigationController).presentedViewController as! UINavigationController).viewControllers.second!.remove(animated: true)
    }
    
    // ******************************* MARK: - Notifications
}
