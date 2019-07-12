//
//  MainFlowDelegate.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import Foundation
import DStorageKit

protocol MainFlowDelegate: ShowUserInfoDelegate,
                            AddUserInfoDelegate {}

protocol ShowUserInfoDelegate: BaseFlowDelegate {
    func showUser(info: UserInfo)
    func handleCollapsingUserSection()
}

protocol AddUserInfoDelegate: BaseFlowDelegate {
    func updateGender()
    func updateDate()
    
    func addNew(user: UserInfo)
}
