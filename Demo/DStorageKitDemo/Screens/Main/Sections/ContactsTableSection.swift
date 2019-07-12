//
//  ContactsSection.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import Foundation
import UIKit
import DStorageKit

class ContactsTableSection: TableSection<ContactTableCell> {
    
    private var usersData: [UserInfo]
    
    private weak var flowDelegate: ShowUserInfoDelegate? {
        return baseFlowDelegate as? ShowUserInfoDelegate
    }
    
    init(with usersData: [UserInfo]) {
        self.usersData = usersData
        
        super.init(priority: 1, minRowsCount: 0, maxRowsCount: Int.max)  // min/max = 1 by default
        
        originRowsCount = usersData.count  // have to implement if you rows count > 1, by default = 1

        sectionRowHeight = 75 // UITableView.automatic by default
        headerHeight = 100 // UITableView.automatic by default
//        footerHeight = 100 // UITableView.automatic by default
    }
    
    public func addNew(info: UserInfo) {
        usersData.insert(info, at: 0)
        originRowsCount = usersData.count
    }
    
    override func configureHeader() -> UIView? {
        let header = HeaderLabelView()
        header.changeTitle(with: "Users")
        header.tapFlowDelegate = self
        return header
    }
    
//    override func configureFooter() -> UIView? {
//        return nil
//    }
    
    override func onCellAdded(at index: Int, cell: ContactTableCell) {

        cell.displayInfo(firstName: usersData[index].firstName, secondName: usersData[index].secondName)
    }
    
    override func onCellSelected(at index: Int, cell: ContactTableCell) {
        flowDelegate?.showUser(info: usersData[index])
    }
}

extension ContactsTableSection: SectionTapDelegateProtocol {
    func onFooterTapped() {
        
    }
    
    func onHeaderTapped() {
        flowDelegate?.handleCollapsingUserSection()
    }
}
