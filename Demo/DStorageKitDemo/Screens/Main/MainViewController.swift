//
//  ViewController.swift
//  dataSourceProject
//
//  Created by Roman Novikov on 7/10/19.
//  Copyright © 2019 Roman Novikov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerParentView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func savePickerAction(_ sender: Any) {
        pickerParentView.isHidden = true
    }
    
    var customDataSource: MainDataSource?
    private let model = ApplicationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerParentView.isHidden = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        datePicker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged)
        
        customDataSource = MainDataSource(with: model, delegate: self)
        customDataSource?.registerCellXibs(in: tableView)
        
        tableView.delegate = customDataSource
        tableView.dataSource = customDataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userVC = segue.destination as? UserViewController,
            let data = sender as? UserInfo {
            userVC.selectedUser = data
        }
    }
    
    @objc private func onDateChanged(_ sender: Any?) {
        customDataSource?.updateDate(date: datePicker.date)
    }
}

extension MainViewController: MainFlowDelegate {
    func updateGender() {
        pickerParentView.isHidden = false
        datePicker.isHidden = true
        pickerView.isHidden = false
    }
    
    func updateDate() {
        pickerParentView.isHidden = false
        datePicker.isHidden = false
        pickerView.isHidden = true
        datePicker.datePickerMode = .date
    }
    
    func addNew(user: UserInfo) {
        model.inserNew(user: user)
        customDataSource?.addNewUser(in: tableView)
    }
    
    func handleCollapsingUserSection() {
        customDataSource?.handleCollapseContactsSection(in: tableView)
    }
    
    func showUser(info: UserInfo) {
        performSegue(withIdentifier: "UserSegue", sender: info)
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GenderTypes(rawValue: row)?.description;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let validGender = GenderTypes(rawValue: row) else { return }
        customDataSource?.updateUser(gender: validGender)
    }
}

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GenderTypes.casesCount
    }
}
