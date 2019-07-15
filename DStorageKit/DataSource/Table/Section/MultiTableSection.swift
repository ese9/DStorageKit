//
//  MultiTableSection.swift
//  DStorageKit
//
//  Created by Roman Novikov on 6/28/19.
//  Copyright © 2019 SolbegSoft. All rights reserved.
//

import UIKit

open class MultiTableSection: TableSection<UITableViewCell> {
    
    private var _wrappers: [CellWrapperProtocol] = []
    private var _innerWrappers: [String: CellWrapperProtocol] = [:]
    
    public subscript<T: CellWrapperProtocol>(key: String) -> T? {
        return _innerWrappers[key] as? T
    }
    
    public func addWrapper(with keyName: String, wrapper: CellWrapperProtocol) {
        _wrappers.append(wrapper)
        _wrappers.sort { $0.cellPriority < $1.cellPriority }
        _innerWrappers[keyName] = wrapper
    }
    
    public func removeWrapper(with key: String) {
        let castedWrappers = _wrappers as [CellWrapperConfig]
        if let wrapper = _innerWrappers.removeValue(forKey: key),
            let wrapperIndex = castedWrappers.firstIndex(of: wrapper) {
            _wrappers.remove(at: wrapperIndex)
        }
    }
    
    public override func cellType(for row: Int = 0) -> UITableViewCell.Type {
        return _wrappers[row].cellType(for: row)
    }
}
