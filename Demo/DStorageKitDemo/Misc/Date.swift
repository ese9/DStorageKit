//
//  Date.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/12/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

extension Date {
    func format(mask: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = mask
        return dateFormatter.string(from: self)
    }
}
