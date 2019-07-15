//
//  TableSectionConfig.swift
//  DStorageKit
//
//  Created by Roman Novikov on 7/15/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

open class TableSectionConfig: DStorageConfig {
    
    internal var headerView: UIView?
    internal var footerView: UIView?
    internal var activeRowsCount: Int = -1
    internal let maxRowsForSection: Int
    internal let minRowsForSection: Int
    internal let sectionPriority: Int  // 0 - max priority
    
    open var sectionRowHeight = UITableView.automaticDimension
    open var headerHeight = UITableView.automaticDimension
    open var footerHeight = UITableView.automaticDimension
    
    internal init(priority: Int, minRowsCount: Int = 1, maxRowsCount: Int = 1) {
        self.sectionPriority = priority
        self.minRowsForSection = minRowsCount
        self.maxRowsForSection = maxRowsCount
    }
}


open class DStorageConfig: Equatable {
    public static func == (lhs: DStorageConfig, rhs: DStorageConfig) -> Bool {
        return lhs.configId == rhs.configId
    }
    
    private var configId = UUID()
}
