//
//  MultiTableCell.swift
//  DSStorageKit
//
//  Created by Roman Novikov on 6/28/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import Foundation
import UIKit

open class MultiCellWrapperConfig {
    let cellPriority: Int
    
    init(priority: Int) {
        self.cellPriority = priority
    }
}

open class MultiTableCellWrapper<T: UITableViewCell, U: TableSectionConfig>: MultiCellWrapperConfig, TableCellActionableProtocol {
    public weak var wrapperOwner: U?
    public var cellType: UITableViewCell.Type { return T.self }
    open func onCellAdded(at index: Int, cell: T) {}
    open func onCellSelected(at index: Int, cell: T) {}
    open func onCellRemoved(at index: Int, cell: T) {}
    open func onCellUpdated(cell: T) {}
    
    init(priority: Int, wrapperOwner: U?) {
        self.wrapperOwner = wrapperOwner
        super.init(priority: priority)
    }
}

extension MultiTableCellWrapper: TableCellControlableProtocol {
    public func cellAdded(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        onCellAdded(at: index, cell: validCell)
    }
    
    public func cellSelected(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        onCellSelected(at: index, cell: validCell)
    }
    public func cellRemoved(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        onCellRemoved(at: index, cell: validCell)
    }
    public func cellUpdated(cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        onCellUpdated(cell: validCell)
    }
}
