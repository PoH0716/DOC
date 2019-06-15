//
//  RegisterViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/26/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var doctorPicker: UIPickerView!
    @IBOutlet weak var registerButton: UIButton!
    
    var doctorName = ["Purva Parwal", "Palak Parwal", "Aaron Toop", "Steven Strange"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return doctorName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return doctorName[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        registerButton.layer.cornerRadius = 20

        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.doctorPicker.delegate = self
        self.doctorPicker.dataSource = self
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        if let myFirstName = firstNameField.text, let myLastName = lastNameField.text, let myEmail = emailField.text, let myPassword = passwordField.text {
            let index = doctorPicker.selectedRow(inComponent: 0)
            let myDoctor = doctorName[index]
            let uid = UUID().uuidString
            User.instance.userId = uid
            User.instance.firstName = myFirstName
            User.instance.lastName = myLastName
            User.instance.email = myEmail
            User.instance.password = myPassword
            User.instance.doctor = myDoctor
            User.instance.doctorId = index + 2
            
            User.instance.registerUser(
                success: {
                    UserDefaults.standard.set(uid, forKey: "userID")
                    Symptom.instance.initDefaultSymptoms(
                        success: {print("Default initialized")},
                        failure: {print("Failed to initialize")}
                    )
                    User.instance.storeUserInfo(
                        success: {
                            let alert = UIAlertController(title: "Success", message: "An email verification has been sent. Please verify your information before logging in.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (err) in
                                self.performSegue(withIdentifier: "SignUpSegue", sender: self)
                            }))
                            self.present(alert, animated: true)
                        },
                        failure: {
                            let alert = UIAlertController(title: "Error", message: "Failed to create a new user.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    )
                },
                failure: {
                    let alert = UIAlertController(title: "Error", message: "Failed to create a new account.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            )
            
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Please fill out all of the required information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField{
            lastNameField.becomeFirstResponder()
        }
        else if textField == lastNameField{
            emailField.becomeFirstResponder()
        }
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        return true
    }
}
