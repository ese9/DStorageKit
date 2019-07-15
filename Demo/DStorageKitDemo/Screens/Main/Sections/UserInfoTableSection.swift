//
//  FilterTableSection.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/11/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import Foundation
import UIKit
import DStorageKit

typealias CompletionBlock = () -> Void

final class UserInfoTableSection: MultiTableSection {
    
    fileprivate var firstName: String?
    fileprivate var lastName: String?
    fileprivate var date: Date? = Date()
    fileprivate var gender: GenderTypes? = .male
    
    fileprivate weak var flowDelegate: AddUserInfoDelegate? {
        return baseFlowDelegate as? AddUserInfoDelegate
    }
    
    private let saveUserKey = "saveUser"
    private let genderPickKey = "genderPick"
    private let datePickKey = "datePick"
    private let inputKey = "inputKey"
    
    
    init() {
        super.init(priority: 0, minRowsCount: 0 ,maxRowsCount: Int.max)
        
        addWrapper(with: saveUserKey, wrapper: SaveUserTableCellWrapper(priority: 3, wrapperOwner: self))
        addWrapper(with: genderPickKey, wrapper: PickerViewTableCellWrapper(priority: 1, wrapperOwner: self))
        addWrapper(with: datePickKey, wrapper: PickerDateTableCellWrapper(priority: 2, wrapperOwner: self))
        addWrapper(with: inputKey, wrapper: NameInputCellWrapper( priority: 0, wrapperOwner: self))
        
        originRowsCount = wrappers.count
    }

    override func onCellAddedToSection(at index: Int, cell: UITableViewCell) {
        wrappers[index].cellAdded(at: index, cell: cell)
    }
    
    override func onCellSelectedInSection(at index: Int, cell: UITableViewCell) {
        wrappers[index].cellSelected(at: index, cell: cell)
    }
    
    public func createNewUserInfo(){
        
        guard let first = firstName,
                let last = lastName,
            let gender = gender else { return }
        
        flowDelegate?.addNew(user: UserInfo(firstName: first, secondName: last, gender: gender, age: 1))
    }
    
    public func updateGender(type: GenderTypes) {
        self.gender = type
        
        guard let genderWrapper: PickerViewTableCellWrapper = self[genderPickKey] else { return }
        
        genderWrapper.cellUpdated(at: 0)
    }
    
    public func updateDate(date: Date) {
        self.date = date
        
        guard let dateWrapper: PickerDateTableCellWrapper = self[datePickKey] else { return }
        
        dateWrapper.cellUpdated(at: 0)
    }
}

class NameInputCellWrapper: CellWrapper<NameInputTableViewCell, UserInfoTableSection> {
    override func onCellAddedToSection(at index: Int, cell: NameInputTableViewCell) {
        cell.firstNameChanged = { [weak self] (text) in
            self?.wrapperOwner?.firstName = text
        }
        
        cell.lastNameChanged = { [weak self] (text) in
            self?.wrapperOwner?.lastName = text
        }
    }
}

class PickerViewTableCellWrapper: CellWrapper<PickerTableViewCell, UserInfoTableSection> {
    override func onCellAddedToSection(at index: Int, cell: PickerTableViewCell) {
         cell.showInformation(title: "Gender", description: wrapperOwner?.gender?.description)
    }
    
    override func onCellSelectedInSection(at index: Int, cell: PickerTableViewCell) {
        wrapperOwner?.flowDelegate?.updateGender()
    }
    
    override func onCellUpdatedInSection(cell: PickerTableViewCell) {
        cell.showInformation(title: "Gender", description: wrapperOwner?.gender?.description)
    }
}

class PickerDateTableCellWrapper: CellWrapper<PickerTableViewCell, UserInfoTableSection> {
    final override func onCellAddedToSection(at index: Int, cell: PickerTableViewCell) {
        let dateString = self.wrapperOwner?.date?.format(mask: "MMM d, yyyy")
        cell.showInformation(title: "Date", description: dateString)
    }
   
    override func onCellSelectedInSection(at index: Int, cell: PickerTableViewCell) {
        wrapperOwner?.flowDelegate?.updateDate()
    }
    
    override func onCellUpdatedInSection(cell: PickerTableViewCell) {
        let dateString = self.wrapperOwner?.date?.format(mask: "MMM d, yyyy")
        cell.showInformation(title: "Date", description: dateString)
    }
}

class SaveUserTableCellWrapper: CellWrapper<SaveUserTableViewCell, UserInfoTableSection> {
    override func onCellAddedToSection(at index: Int, cell: SaveUserTableViewCell) {
        cell.completion = { [weak self] in
            self?.wrapperOwner?.createNewUserInfo()
        }
    }
}
