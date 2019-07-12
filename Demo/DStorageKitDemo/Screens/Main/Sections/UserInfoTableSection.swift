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

class UserInfoTableSection: MultiTableSection {
    
    fileprivate var firstName: String?
    fileprivate var lastName: String?
    fileprivate var date: Date? = Date()
    fileprivate var gender: GenderTypes? = .male
    
    fileprivate weak var flowDelegate: AddUserInfoDelegate? {
        return baseFlowDelegate as? AddUserInfoDelegate
    }
    
    private var pickerViewWrapper: PickerViewTableCellWrapper?
    private var pickerDateWrapper: PickerDateTableCellWrapper?
    
    init() {
        super.init(priority: 0, minRowsCount: 0 ,maxRowsCount: Int.max)
        
        let inputWrapper = NameInputCellWrapper(priority: 0, wrapperOwner: self)
        let saveUser = SaveUserTableCellWrapper(priority: 3, wrapperOwner: self)
        pickerViewWrapper = PickerViewTableCellWrapper(priority: 1, wrapperOwner: self)
        pickerDateWrapper = PickerDateTableCellWrapper(priority: 2, wrapperOwner: self)

        addWrapper(wrapper: saveUser)
        addWrapper(wrapper: pickerViewWrapper!)
        addWrapper(wrapper: pickerDateWrapper!)
        addWrapper(wrapper: inputWrapper)
        
        originRowsCount = wrappers.count
    }

    override func onCellAdded(at index: Int, cell: UITableViewCell) {
        wrappers[index].cellAdded(at: index, cell: cell)
    }
    
    override func onCellSelected(at index: Int, cell: UITableViewCell) {
        wrappers[index].cellSelected(at: index, cell: cell)
    }
    
    public func createNewUserInfo(){
        
        guard let first = firstName,
                let last = lastName,
            let gender = gender else { return }
        debugPrint("adad")
        flowDelegate?.addNew(user: UserInfo(firstName: first, secondName: last, gender: gender, age: 1))
    }
    
    public func updateGender(type: GenderTypes) {
        self.gender = type
        
        guard let index = pickerViewWrapper?.cellPriority,
            let cell = cells[index] else { return }
        
        pickerViewWrapper?.cellUpdated(cell: cell)
    }
    
    public func updateDate(date: Date) {
        self.date = date
        
        guard let index = pickerDateWrapper?.cellPriority,
            let cell = cells[index] else { return }
        
        pickerDateWrapper?.cellUpdated(cell: cell)
    }
}

class NameInputCellWrapper: MultiTableCellWrapper<NameInputTableViewCell, UserInfoTableSection> {
    override func onCellAdded(at index: Int, cell: NameInputTableViewCell) {
        cell.firstNameChanged = { [weak self] (text) in
            self?.wrapperOwner?.firstName = text
        }
        
        cell.lastNameChanged = { [weak self] (text) in
            self?.wrapperOwner?.lastName = text
        }
    }
}

class PickerViewTableCellWrapper: MultiTableCellWrapper<PickerTableViewCell, UserInfoTableSection> {
    override func onCellAdded(at index: Int, cell: PickerTableViewCell) {
         cell.showInformation(title: "Gender", description: wrapperOwner?.gender?.description)
    }
    
    override func onCellSelected(at index: Int, cell: PickerTableViewCell) {
        wrapperOwner?.flowDelegate?.updateGender()
    }
    
    override func onCellUpdated(cell: PickerTableViewCell) {
        cell.showInformation(title: "Gender", description: wrapperOwner?.gender?.description)
    }
}

class PickerDateTableCellWrapper: MultiTableCellWrapper<PickerTableViewCell, UserInfoTableSection> {
    final override func onCellAdded(at index: Int, cell: PickerTableViewCell) {
        let dateString = self.wrapperOwner?.date?.format(mask: "MMM d, yyyy")
        cell.showInformation(title: "Date", description: dateString)
    }
   
    override func onCellSelected(at index: Int, cell: PickerTableViewCell) {
        wrapperOwner?.flowDelegate?.updateDate()
    }
    
    override func onCellUpdated(cell: PickerTableViewCell) {
        let dateString = self.wrapperOwner?.date?.format(mask: "MMM d, yyyy")
        cell.showInformation(title: "Date", description: dateString)
    }
}

class SaveUserTableCellWrapper: MultiTableCellWrapper<SaveUserTableViewCell, UserInfoTableSection> {
    override func onCellAdded(at index: Int, cell: SaveUserTableViewCell) {
        cell.completion = { [weak self] in
            self?.wrapperOwner?.createNewUserInfo()
        }
    }
}
