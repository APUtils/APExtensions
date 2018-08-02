//
//  TableViewVC.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/2/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

import APExtensions


class TableViewVC: UIViewController {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // ******************************* MARK: - Private Properties
    
    // ******************************* MARK: - Initialization and Setup
    
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }
    
    private func setup() {
        tableView.handleEstimatedSizeAutomatically = true
    }
}

// ******************************* MARK: - UITableViewDelegate, UITableViewDataSource

extension TableViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
