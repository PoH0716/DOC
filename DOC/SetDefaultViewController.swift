//
//  SetDefaultViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/27/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit

class SetDefaultViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var symptomLabel: UILabel!
    @IBOutlet weak var severityPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    var severity = ["0", "1", "2", "3", "4"]
    var index = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return severity.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return severity[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 20
        
        self.severityPicker.delegate = self
        self.severityPicker.dataSource = self
        
        symptomLabel.text = Symptom.instance.description
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Symptom.instance.fetchDefault(userCompletionHandler: { user, error in
            if let user = user {
                self.index = user
                self.severityPicker.selectRow(self.index, inComponent: 0, animated: true)
            }
        })
    }
    
    @IBAction func saveSymptom(_ sender: Any) {
        User.instance.severity = severityPicker.selectedRow(inComponent: 0)
        Symptom.instance.saveDefault(Type: User.instance.selectedType, Category: User.instance.selectedCategory, Symptom: User.instance.selectedSymptom, Severity: User.instance.severity)
    }
    
}
