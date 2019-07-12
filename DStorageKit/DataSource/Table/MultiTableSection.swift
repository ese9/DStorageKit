//
//  MultiTableSection.swift
//  DSStorageKit
//
//  Created by Roman Novikov on 6/28/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import Foundation
import UIKit

open class MultiTableSection: TableSection<UITableViewCell> {
    
    private(set) var wrappers: [TableCellControlableProtocol] = [] {
        didSet {
            wrappers.sort { $0.cellPriority < $1.cellPriority }
        }
    } 
    
    func addWrapper(wrapper: TableCellControlableProtocol) {
        wrappers.append(wrapper)
    }
    
    func removeWrapper(at index: Int) {
        wrappers.remove(at: index)
    }
    
    final override func cellType(for row: Int = 0) -> UITableViewCell.Type {
        return wrappers[row].cellType
    }
}
