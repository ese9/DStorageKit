//
//  TableSectionActionableProtocol.swift
//  DStorageKit
//
//  Created by Roman Novikov on 7/15/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//


public protocol TableSectionActionableProtocol {
    var originRowsCount: Int { get set }
    var isSectionCollapsed: Bool { get }
    
    func collapseSection()
    func expandSection()
}
