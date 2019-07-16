//
//  BaseDataSource.swift
//  DStorageKit
//
//  Created by Roman Novikov on 6/20/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import UIKit

open class TableDataSource: NSObject {
    
    public subscript<T: TableSectionProtocol>(key: String) -> T? {
        return _innerSections[key] as? T
    }
    
    private var _sections: [TableSectionProtocol] = []
    private var _innerSections: [String: TableSectionProtocol] = [:]
    
    public func addNewSection(with keyName: String, _ section: TableSectionProtocol) {
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
    
    public func handleSectionCollapsing(in tableView: UITableView, with key: String) {
        guard let section = _innerSections[key],
            let index = getSectionIndex(key: key) else { return }
        
        var indexPaths: [IndexPath] = []
    
        for row in 0..<section.originRowsCount {
            let indexPath = IndexPath(row: row, section: index)
            indexPaths.append(indexPath)
        }
        
        if section.isSectionCollapsed {
            section.expandSection()
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            indexPaths.forEach {
                if let cell = tableView.cellForRow(at: $0) {
                    section.cellRemoved(at: $0.row, cell: cell)
                }
            }
            
            section.collapseSection()
            tableView.deleteRows(at: indexPaths, with: .none)
        }
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
        section.cellRemoved(at: indexPath.row, cell: cell)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let section = _sections[indexPath.section]
         section.cellAdded(at: indexPath.row, cell: cell)
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
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        _sections[indexPath.section].cellSelected(at: indexPath.row, cell: cell)
    }
}
