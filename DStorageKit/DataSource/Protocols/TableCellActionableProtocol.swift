//
//  TableCellActionableProtocol.swift
//  DSStorageKit
//
//  Created by Roman Novikov on 7/12/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

protocol TableCellActionableProtocol: class {
    associatedtype T: UITableViewCell
    func onCellAdded(at index: Int, cell: T)
    func onCellSelected(at index: Int, cell: T)
    func onCellRemoved(at index: Int, cell: T)
    func onCellUpdated(cell: T)
}
