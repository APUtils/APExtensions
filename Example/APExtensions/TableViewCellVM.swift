//
//  TableViewCellVM.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/11/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import APExtensions
import UIKit

private var maxStringLength: Int { .random(in: 0...200) }

struct TableViewCellVM {
    var text: String = .random(length: maxStringLength, averageWordLength: 5)
}
