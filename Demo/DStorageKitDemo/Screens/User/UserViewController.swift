//
//  UserViewController.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var firsNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    
    public var selectedUser: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let validUser = selectedUser else {
            firsNameLabel.text = nil
            secondNameLabel.text = nil
            ageLabel.text = "Corrupted user info"
            return
        }
        
        firsNameLabel.text = validUser.firstName
        secondNameLabel.text = validUser.secondName
        ageLabel.text = "I'm \(validUser.age) years old"
        // Do any additional setup after loading the view.
    }
}
