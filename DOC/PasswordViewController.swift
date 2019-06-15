//
//  PasswordViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/26/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        resetButton.layer.cornerRadius = 20
        
        emailField.delegate = self
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        emailField.resignFirstResponder()

        if let myEmail = emailField.text {
            Authenticate.instance.passwordReset(theEmail: myEmail, success: {
                let alert = UIAlertController(title: "Success", message: "Email Sent!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (err) in
                    self.performSegue(withIdentifier: "ResetSegue", sender: self)
                }))
                self.present(alert, animated: true)
            }) {
                let alert = UIAlertController(title: "Error", message: "Email not found, please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -(self.view.frame.width * 0.22)
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resetPassword(self)
        return true
    }
}
