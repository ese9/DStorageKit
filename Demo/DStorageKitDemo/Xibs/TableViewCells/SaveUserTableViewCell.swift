//
//  SaveUserTableViewCell.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/11/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

class SaveUserTableViewCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    
    var completion: CompletionBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        saveButton.addTarget(self, action: #selector(onSaveButtonPressed), for: .touchUpInside)
    }
    
    
    func setButton(hidden: Bool) {
        saveButton.isHidden = hidden
    }
    
    @objc private func onSaveButtonPressed() {
        completion?()
    }
    

}
