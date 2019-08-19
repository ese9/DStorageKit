//
//  TableSection.swift
//  DStorageKit
//
//  Created by Roman Novikov on 6/14/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import UIKit

public protocol TableSectionProtocol: TableSectionConfig,
                                        TableCellControlableProtocol,
                                        TableSectionActionableProtocol{
    
}

open class TableSection<T: UITableViewCell>: TableSectionConfig, TableSectionProtocol, TableCellActionableProtocol {
    
    private var _cells: [Int:T] = [:]
    
    public weak var baseFlowDelegate: BaseFlowDelegate?
    public var originRowsCount: Int = 1 {
        didSet {
            originRowsCount = min(max(originRowsCount, minRowsForSection), maxRowsForSection)
            if !isSectionCollapsed {
                activeRowsCount = originRowsCount
            }
        }
    }
    
    public private(set) var isSectionCollapsed: Bool = false
    
    public override init(priority: Int, minRowsCount: Int = 1, maxRowsCount: Int = 1) {
        super.init(priority: priority, minRowsCount: minRowsCount, maxRowsCount: maxRowsCount)
        headerView = self.configureHeader()
        footerView = self.configureFooter()
    }
    
    public func cellType(for row: Int = 0) -> UITableViewCell.Type {
        return T.self
    }
    
    // MARK: Abstract functions
    open func onCellPreparedInSection(at index: Int, cell: T) {}
    open func onCellAddedToSection(at index: Int, cell: T) {}
    open func onCellRemovedFromSection(at index: Int, cell: T) {}
    open func onCellSelectedInSection(at index: Int, cell: T) {}
    open func onCellUpdatedInSection(at index: Int, cell: T) {}
    open func configureHeader() -> UIView? { return nil }
    open func configureFooter() -> UIView? { return nil }
}

extension TableSection: TableCellControlableProtocol {
    public func cellPrepared(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        _cells[index] = validCell
        onCellPreparedInSection(at: index, cell: validCell)
    }
    
    public final func cellAdded(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        _cells[index] = validCell
        onCellAddedToSection(at: index, cell: validCell)
    }
    
    public final func cellSelected(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        onCellSelectedInSection(at: index, cell: validCell)
    }
    
    public final func cellUpdated(at index: Int) {
        guard let validCell = _cells[index] else { return }
        onCellUpdatedInSection(at: index, cell: validCell)
    }
    
    public final func cellRemoved(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
        _cells.removeValue(forKey: index)
        onCellRemovedFromSection(at: index, cell: validCell)
    }
}

extension TableSection: TableSectionActionableProtocol {
    public func collapseSection() {
        activeRowsCount = 0
        isSectionCollapsed = true
    }
    
    public func expandSection() {
        activeRowsCount = originRowsCount
        isSectionCollapsed = false
    }
}
