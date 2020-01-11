//
//  TableViewCell.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/11/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import APExtensions
import UIKit

final class TableViewCell: UITableViewCell {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private var label: UILabel!
    
    // ******************************* MARK: - Initialization and Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    private func setup() {
        
    }
    
    // ******************************* MARK: - Configuration
    
    func configure(vm: TableViewCellVM) {
        label.text = vm.text
    }
}

// ******************************* MARK: - InstantiatableFromXib

extension TableViewCell: InstantiatableFromXib {}
