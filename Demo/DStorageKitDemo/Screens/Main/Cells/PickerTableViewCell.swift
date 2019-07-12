//
//  GenderTableViewCell.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/11/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func showInformation(title: String, description: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    
}
