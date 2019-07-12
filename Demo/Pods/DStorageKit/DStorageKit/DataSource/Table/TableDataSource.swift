//
//  BaseDataSource.swift
//  DSStorageKit
//
//  Created by Roman Novikov on 6/20/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import Foundation
import UIKit

open class TableDataSource: NSObject {
    
    private var _sections: [TableSectionConfigurableProtocol] = [] {
        didSet {
            _sections.sort { $0.sectionPriority < $1.sectionPriority }
        }
    }
    
    public var sections: [TableSectionConfigurableProtocol] { return _sections }
    
    public func addNewSection(_ section: TableSectionConfigurableProtocol) {
        _sections.append(section)
    }
    
    public func removeSection(at index: Int) {
        _sections.remove(at: index)
    }
}

extension TableDataSource: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].activeRowsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: section.cellType(for: indexPath.row)))
        return cell!
    }
}

extension TableDataSource: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.removeFromSection(at: indexPath.row, cell: cell)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let section = sections[indexPath.section]
         section.addToSection(at: indexPath.row, cell: cell)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footerHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = sections[section].headerView
        header?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: sections[section].headerHeight)
        return header
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = sections[section].footerView
        footerView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: sections[section].footerHeight)
        return footerView
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].sectionRowHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        sections[indexPath.section].didSelectCellAt(index: indexPath.row, cell: cell)
    }
}
