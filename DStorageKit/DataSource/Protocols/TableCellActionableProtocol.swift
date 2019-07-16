//
//  TableCellActionableProtocol.swift
//  DStorageKit
//
//  Created by Roman Novikov on 7/12/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

public protocol TableCellActionableProtocol: class {
    associatedtype T: UITableViewCell
    func onCellAddedToSection(at index: Int, cell: T)
    func onCellSelectedInSection(at index: Int, cell: T)
    func onCellRemovedFromSection(at index: Int, cell: T)
    func onCellUpdatedInSection(at index: Int, cell: T)
}
