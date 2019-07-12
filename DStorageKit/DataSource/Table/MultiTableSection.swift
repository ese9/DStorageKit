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
    
    private var _wrappers: [TableCellControlableProtocol] = [] {
        didSet {
            _wrappers.sort { $0.cellPriority < $1.cellPriority }
        }
    }
    
    public var wrappers: [TableCellControlableProtocol] { return _wrappers }
    
    public func addWrapper(wrapper: TableCellControlableProtocol) {
        _wrappers.append(wrapper)
    }
    
    public func removeWrapper(at index: Int) {
        _wrappers.remove(at: index)
    }
    
    public override func cellType(for row: Int = 0) -> UITableViewCell.Type {
        return wrappers[row].cellType
    }
}
