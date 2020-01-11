//
//  TableViewVM.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/11/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

struct TableViewVM {
    
    // ******************************* MARK: - Public Properties
    
    static let cellsCount: Int = 100
    
    // ******************************* MARK: - Public Properties
    
    var cellVMs: [TableViewCellVM]
    
    // ******************************* MARK: - Initialization and Setup
    
    init() {
        self.cellVMs = stride(from: 0, to: TableViewVM.cellsCount, by: 1)
            .map { _ in TableViewCellVM() }
    }
    
}
