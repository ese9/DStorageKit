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
    
    public subscript<T: TableSectionConfigurableProtocol>(key: String) -> T? {
        return _innerSections[key] as? T
    }
    
    private var _sections: [TableSectionConfigurableProtocol] = []
    private var _innerSections: [String: TableSectionConfigurableProtocol] = [:]
    
    public func addNewSection(with keyName: String, _ section: TableSectionConfigurableProtocol) {
        _sections.append(section)
        _sections.sort { $0.sectionPriority < $1.sectionPriority }
        _innerSections[keyName] = section
    }
    
    public func removeSection(with key: String) {
        let castedSections = _sections as [TableSectionConfig]
        if let section = _innerSections.removeValue(forKey: key),
            let sectionIndex = castedSections.firstIndex(of: section) {
            _sections.remove(at: sectionIndex)
        }
    }
    
    public func getSectionIndex(key sectionKey: String) -> Int? {
        guard let section: TableSectionConfig = _innerSections[sectionKey] else { return nil }
        let castedSections = _sections as [TableSectionConfig]
        return castedSections.firstIndex(of: section)
    }
}

extension TableDataSource: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return _sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _sections[section].activeRowsCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = _sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: section.cellType(for: indexPath.row)))
        return cell!
    }
}

extension TableDataSource: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = _sections[indexPath.section]
        section.removeFromSection(at: indexPath.row, cell: cell)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let section = _sections[indexPath.section]
         section.addToSection(at: indexPath.row, cell: cell)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return _sections[section].headerHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return _sections[section].footerHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = _sections[section].headerView
        header?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: _sections[section].headerHeight)
        return header
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = _sections[section].footerView
        footerView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: _sections[section].footerHeight)
        return footerView
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _sections[indexPath.section].sectionRowHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        _sections[indexPath.section].didSelectCellAt(index: indexPath.row, cell: cell)
    }
}
