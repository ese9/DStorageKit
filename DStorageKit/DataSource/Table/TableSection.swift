//
//  TableSection.swift
//  DSStorageKit
//
//  Created by Roman Novikov on 6/14/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import UIKit

public protocol TableSectionConfigurableProtocol: TableSectionConfig {
    var isCollapsed: Bool { get }
    
    func addToSection(at index: Int, cell: UITableViewCell)
    func removeFromSection(at index: Int, cell: UITableViewCell)
    func didSelectCellAt(index: Int, cell: UITableViewCell?)
    func cellType(for row: Int) -> UITableViewCell.Type

    func collapseSection()
    func expandSection()
}

open class TableSectionConfig {
    var headerView: UIView?
    var footerView: UIView?
    open var sectionRowHeight = UITableView.automaticDimension
    open var headerHeight = UITableView.automaticDimension
    open var footerHeight = UITableView.automaticDimension
    var activeRowsCount: Int = -1
    
    let maxRowsForSection: Int
    let minRowsForSection: Int
    let sectionPriority: Int  // 0 - max priority
    
    init(priority: Int, minRowsCount: Int = 1, maxRowsCount: Int = 1) {
        self.sectionPriority = priority
        self.minRowsForSection = minRowsCount
        self.maxRowsForSection = maxRowsCount
    }
}

open class TableSection<T: UITableViewCell>: TableSectionConfig, TableCellActionableProtocol {
    
    public weak var baseFlowDelegate: BaseFlowDelegate?
    public var originRowsCount: Int = 1 {
        didSet {
            originRowsCount = min(max(originRowsCount, minRowsForSection), maxRowsForSection)
            if !isCollapsed {
                activeRowsCount = originRowsCount
            }
        }
    }
    
    public var isCollapsed: Bool {
        return activeRowsCount == 0
    }
    

    override init(priority: Int, minRowsCount: Int = 1, maxRowsCount: Int = 1) {
        super.init(priority: priority, minRowsCount: minRowsCount, maxRowsCount: maxRowsCount)
        headerView = self.configureHeader()
        footerView = self.configureFooter()
    }
    
    public var cells: [Int:T] = [:]
    
    public func cellType(for row: Int = 0) -> UITableViewCell.Type {
        return T.self
    }
    
    // MARK: Abstract functions
    open func onCellAdded(at index: Int, cell: T) {}
    open func onCellRemoved(at index: Int, cell: T) {}
    open func onCellSelected(at index: Int, cell: T) {}
    open func onCellUpdated(cell: T) {}
    open func configureHeader() -> UIView? { return nil }
    open func configureFooter() -> UIView? { return nil }
}

extension TableSection: TableSectionConfigurableProtocol {
    public func addToSection(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
            cells[index] = validCell
            onCellAdded(at: index, cell: validCell)
    }
    
    public func removeFromSection(at index: Int, cell: UITableViewCell) {
        guard let validCell = cell as? T else { return }
            cells.removeValue(forKey: index)
            onCellRemoved(at: index, cell: validCell)
        
    }
    
    public func didSelectCellAt(index: Int, cell: UITableViewCell?) {
        guard let validCell = cell as? T else { return }
        onCellSelected(at: index, cell: validCell)
    }
    
    public func collapseSection() {
        activeRowsCount = 0
    }
    
    public func expandSection() {
        activeRowsCount = originRowsCount
    }
}
