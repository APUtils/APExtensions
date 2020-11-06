//
//  CustomPageSizeVC.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 11/6/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import APExtensions
import UIKit

final class CustomPageSizeVC: UIViewController {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private var scrollView: UIScrollView!
    
    // ******************************* MARK: - Private Properties
    
    // ******************************* MARK: - Initialization and Setup
    
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }
    
    private func setup() {
        scrollView.delegate = self
        scrollView.decelerationRate = .fast
    }
    
    // ******************************* MARK: - UIViewController Overrides
    
    // ******************************* MARK: - Actions
    
    // ******************************* MARK: - Notifications
}

extension CustomPageSizeVC: ScrollViewCustomHorizontalPageSize {
    var pageSize: CGFloat {
        return 200
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee.x = getTargetContentOffset(scrollView: scrollView, velocity: velocity)
    }
}
