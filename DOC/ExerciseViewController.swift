//
//  ExerciseViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/5/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit
import Firebase

class ExerciseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var activitiesPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    let db = Firestore.firestore()
    let intensity = ["Low", "Moderate", "High"]
    let time = ["15", "30", "45", "60", "75", "90", "105", "120", ">120"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 1:
            return time.count
        default:
            return intensity.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 1:
            return time[row]
        default:
            return intensity[row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        saveButton.layer.cornerRadius = 20
        
        self.activitiesPicker.delegate = self
        self.activitiesPicker.dataSource = self
    }

    @IBAction func saveButton(_ sender: Any) {
        let index1 = activitiesPicker.selectedRow(inComponent: 0)
        let index2 = activitiesPicker.selectedRow(inComponent: 1)
        let magnitude = intensity[index1]
        let length: Int? = Int(time[index2])

        db.collection("Users/\(User.instance.userId!)/Dates/\(User.instance.getDate())/Activities").document("Intensity and time").setData([magnitude: length!], merge: true) {err in
            if let err = err {
                print("Error saving activities: \(err)")
            } else {
                print("Activities saved")
            }
        }
        
        let alert = UIAlertController(title: "Success", message: "Your activities have been saved and available for your doctor to view!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (err) in
            print("Alert activities saved")
        }))
        self.present(alert, animated: true)

    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -(self.view.frame.height * 0.1)
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
        
}
