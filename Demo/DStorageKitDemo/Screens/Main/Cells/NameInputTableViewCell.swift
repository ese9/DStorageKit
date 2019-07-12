//
//  InputTableViewCell.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

typealias TextChangedAction = (String?) -> Void

class NameInputTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    var firstNameChanged: TextChangedAction? {
        didSet {
            firstNameDelegate?.textChanged = firstNameChanged
        }
    }
    var lastNameChanged: TextChangedAction? {
        didSet {
            lastNameDelegate?.textChanged = lastNameChanged
        }
    }
    
    private var firstNameDelegate: InputFieldDelegate?
    private var lastNameDelegate: InputFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstNameDelegate = InputFieldDelegate()
        lastNameDelegate = InputFieldDelegate()
        
        
        firstNameField.delegate = firstNameDelegate
        lastNameField.delegate = lastNameDelegate
    }
    
    class InputFieldDelegate: NSObject, UITextFieldDelegate {
        var textChanged: TextChangedAction?
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            textChanged?(textField.text)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
    }
}
