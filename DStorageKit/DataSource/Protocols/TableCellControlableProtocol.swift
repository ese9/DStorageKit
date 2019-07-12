//
//  TableCellControlableProtocol.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/12/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

protocol TableCellControlableProtocol: MultiCellWrapperConfig {
    var cellType: UITableViewCell.Type { get }
    func cellAdded(at index: Int, cell: UITableViewCell)
    func cellSelected(at index: Int, cell: UITableViewCell)
    func cellUpdated(cell: UITableViewCell)
    func cellRemoved(at index: Int, cell: UITableViewCell)
}
