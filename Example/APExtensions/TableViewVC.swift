//
//  TableViewVC.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 8/2/18.
//  Copyright © 2019 Anton Plebanovich All rights reserved.
//

import APExtensions
import UIKit

class TableViewVC: UIViewController {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // ******************************* MARK: - Private Properties
    
    private var cellsCount = 100
    
    // ******************************* MARK: - Initialization and Setup
    
    deinit {
        print("deinit \(self)")
    }
    
    override func viewDidLoad() {
        print("viewDidLoad \(self)")
        setup()
        super.viewDidLoad()
    }
    
    private func setup() {
        tableView.handleEstimatedSizeAutomatically = true
    }
    
    // ******************************* MARK: - Actions
    
    @IBAction private func onDebugTap(_ sender: Any) {
        cellsCount -= 1
//        tableView.insertRows(at: [tableView.firstRowIndexPath], with: .none)
        tableView.deleteRows(at: [tableView.firstRowIndexPath], with: .none)
    }
}

// ******************************* MARK: - UITableViewDelegate, UITableViewDataSource

extension TableViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
