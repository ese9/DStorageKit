//
//  MainDataSource.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import Foundation
import UIKit
import DStorageKit

class MainDataSource: TableDataSource {
    
    var dataModel: ApplicationModel?
    
    var contactsSection: ContactsTableSection!
    var newUserInfoSection: UserInfoTableSection!
    
    init(with model: ApplicationModel?, delegate: MainFlowDelegate) {
        self.dataModel = model
        super.init()
        
        
    
        assert(model != nil, "data == nil")
        assert(model!.users.count > 0, "users == 0")
        
        contactsSection = ContactsTableSection(with: model!.users)
        contactsSection.baseFlowDelegate = delegate
        addNewSection(contactsSection!)
        
        newUserInfoSection = UserInfoTableSection()
        newUserInfoSection.baseFlowDelegate = delegate
        addNewSection(newUserInfoSection)
    }
    
    func registerCellXibs(in tableView: UITableView) {
        let cellId = String(describing: SaveUserTableViewCell.self)
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func handleCollapseContactsSection(in tableView: UITableView) {
        
        guard let validSection = contactsSection,
            let validModel = dataModel else { return }
        
        var indexPaths: [IndexPath] = []
        
        for row in validModel.users.indices {
            let indexPath = IndexPath(row: row, section: validSection.sectionPriority)
            indexPaths.append(indexPath)
        }

        if sections[validSection.sectionPriority].isCollapsed {
            sections[validSection.sectionPriority].expandSection()
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            indexPaths.forEach {
                if let cell = tableView.cellForRow(at: $0) {
                    sections[validSection.sectionPriority].removeFromSection(at: $0.row, cell: cell)
                }
            }
        
            sections[validSection.sectionPriority].collapseSection()
            
            tableView.deleteRows(at: indexPaths, with: .none)
        }
    }
    
    func addNewUser(in tableView: UITableView) {
        
        contactsSection?.addNew(info: dataModel!.users.first!)
        
//        tableView.reloadSections(IndexSet(integer: contactsSection!.sectionPriority), with: .automatic)  // 1

        if contactsSection!.isCollapsed {                                 // 2
            handleCollapseContactsSection(in: tableView)
        } else {
            tableView.insertRows(at: [IndexPath(row: 0, section: contactsSection!.sectionPriority)], with: .automatic)
            tableView.scrollToRow(at: IndexPath(row: 0, section: contactsSection!.sectionPriority), at: .bottom, animated: true)
        }
    }
    
    func updateUser(gender: GenderTypes) {
        newUserInfoSection?.updateGender(type: gender)
    }
    
    func updateDate(date: Date) {
        newUserInfoSection?.updateDate(date: date)
    }
}
