//
//  ContactTableCell.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

class ContactTableCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    
    func displayInfo(firstName: String, secondName: String) {
        firstNameLabel.text = firstName
        secondNameLabel.text = secondName
    }

}
