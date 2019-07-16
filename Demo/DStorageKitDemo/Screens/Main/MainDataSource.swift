//
//  MainDataSource.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import Foundation
import UIKit
#if canImport(DStorageKit)
import DStorageKit
#endif

class MainDataSource: TableDataSource {
    
    private var dataModel: ApplicationModel?
    
    private let contactSectionKey: String = "contacts"
    private let newUserSectionKey: String = "newUser"
    
    
    init(with model: ApplicationModel?, delegate: MainFlowDelegate) {
        self.dataModel = model
        super.init()
        
        assert(model != nil, "data == nil")
        assert(model!.users.count > 0, "users == 0")
         
        let contactsSection = ContactsTableSection(with: model!.users)
        contactsSection.baseFlowDelegate = delegate
        addNewSection(with: contactSectionKey, contactsSection)
        
        let newUserInfoSection = UserInfoTableSection()
        newUserInfoSection.baseFlowDelegate = delegate
        addNewSection(with: newUserSectionKey, newUserInfoSection)
        
    }
    
    func registerCellXibs(in tableView: UITableView) {
        let cellId = String(describing: SaveUserTableViewCell.self)
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func handleCollapseContactsSection(in tableView: UITableView) {
    
        guard let contactsSection: ContactsTableSection = self[contactSectionKey],
            let contactsIndex = getSectionIndex(key: contactSectionKey),
            let validModel = dataModel else { return }
        
        var indexPaths: [IndexPath] = []
        
        for row in validModel.users.indices {
            let indexPath = IndexPath(row: row, section: contactsIndex)
            indexPaths.append(indexPath)
        }

        if contactsSection.isSectionCollapsed {
            contactsSection.expandSection()
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            indexPaths.forEach {
                if let cell = tableView.cellForRow(at: $0) {
                    contactsSection.cellRemoved(at: $0.row, cell: cell)
                }
            }
        
           contactsSection.collapseSection()
            
            tableView.deleteRows(at: indexPaths, with: .none)
        }
    }
    
    func addNewUser(in tableView: UITableView) {
        guard let contactsSection: ContactsTableSection = self[contactSectionKey],
                let contactsIndex = getSectionIndex(key: contactSectionKey) else { return }
        
        contactsSection.addNew(info: dataModel!.users.first!)
//        tableView.reloadSections(IndexSet(integer: contactsSection!.sectionPriority), with: .automatic)  // 1

        if contactsSection.isSectionCollapsed {                                 // 2
            handleCollapseContactsSection(in: tableView)
        } else {
            
            tableView.insertRows(at: [IndexPath(row: 0, section: contactsIndex)], with: .automatic)
            tableView.scrollToRow(at: IndexPath(row: 0, section: contactsIndex), at: .bottom, animated: true)
        }
    }
    
    func updateUser(gender: GenderTypes) {
        guard let newUserSection: UserInfoTableSection = self[newUserSectionKey] else { return }
        
        newUserSection.updateGender(type: gender)
    }
    
    func updateDate(date: Date) {
        guard let newUserSection: UserInfoTableSection = self[newUserSectionKey] else { return }
        
        newUserSection.updateDate(date: date)
    }
}
