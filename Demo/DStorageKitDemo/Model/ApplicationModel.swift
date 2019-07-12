//
//  ApplicationModel.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import Foundation
import UIKit


class ApplicationModel {
    var users: [UserInfo]
    init() {
        users = [
            UserInfo(firstName: "Sergey", secondName: "Petrov", gender: .male, age: 45),
            UserInfo(firstName: "Anton", secondName: "Gorodeckiy", gender: .male, age: 30),
            UserInfo(firstName: "Michael", secondName: "Jackson", gender: .male, age: 50),
            UserInfo(firstName: "Anastasiya", secondName: "Ivanova", gender: .female, age: 18),
            UserInfo(firstName: "Veronica", secondName: "Lapteva", gender: .female, age: 30)
        ]
    }
    
    public func inserNew(user: UserInfo) {
        users.insert(user, at: 0)
    }
}


struct UserInfo: Equatable {
    let firstName: String
    let secondName: String
    let gender: GenderTypes
    let age: Int
}

enum GenderTypes: Int, CaseIterable {
    case male
    case female
    case unknown
    
    var description: String {
        switch self {
        case .female: return "Female"
        case .male: return "Male"
        case .unknown: return "Unknown"
        }
    }
    
    static var casesCount: Int { return allCases.count }
}
