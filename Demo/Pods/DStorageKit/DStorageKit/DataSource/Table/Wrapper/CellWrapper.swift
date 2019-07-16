//
//  MultiTableCell.swift
//  DStorageKit
//
//  Created by Roman Novikov on 6/28/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import UIKit

public protocol CellWrapperProtocol: CellWrapperConfig,
                                        TableCellControlableProtocol {}

open class CellWrapper<T: UITableViewCell, U: TableSectionConfig>: CellWrapperConfig, CellWrapperProtocol, TableCellActionableProtocol {
    public weak var wrapperOwner: U?
    
    // Abstract functions
    open func onCellAddedToSection(at index: Int, cell: T) {}
    open func onCellSelectedInSection(at index: Int, cell: T) {}
    open func onCellRemovedFromSection(at index: Int, cell: T) {}
    open func onCellUpdatedInSection(cell: T) {}
    
    private var _cell: T?
    
    public init(priority: Int, wrapperOwner: U?) {
        self.wrapperOwner = wrapperOwner
        super.init(priority: priority)
    }
}

extension CellWrapper: TableCellControlableProtocol {
    public final func cellType(for row: Int) -> UITableViewCell.Type {
        return T.self
    }
    
    public final func cellAdded(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        self._cell = cell as? T
        onCellAddedToSection(at: index, cell: validCell)
    }
    
    public final func cellSelected(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        onCellSelectedInSection(at: index, cell: validCell)
    }
    public final func cellRemoved(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        self._cell = nil
        onCellRemovedFromSection(at: index, cell: validCell)
    }
    public final func cellUpdated(at index: Int) {
        guard let validCell = _cell else { return }
        onCellUpdatedInSection(cell: validCell)
    }
}
