//
//  CellWrapperConfig.swift
//  DStorageKit
//
//  Created by Roman Novikov on 7/15/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

open class CellWrapperConfig: DStorageConfig {
    
    internal let cellPriority: Int
    
    init(priority: Int) {
        self.cellPriority = priority
    }
}
