//
//  LoginViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/26/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.instance.userId = UserDefaults.standard.string(forKey: "userID")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        loginButton.layer.cornerRadius = 20
        registerButton.layer.cornerRadius = 20

        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        if let email = emailField.text, let password = passwordField.text {
            Authenticate.instance.userLogin(theEmail: email, thePassword: password, success: {
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
            }) {
                print("failed login...")
                let alert = UIAlertController(title: "Error", message: "Incorrect email or password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
        }
        else{
            print("Email or Password Text Field Cannot be empty!!!....")
            let alert = UIAlertController(title: "Error", message: "Email or Password Text Field Cannot be empty", preferredStyle: .alert)
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
        self.view.frame.origin.y = -(self.view.frame.height * 0.22)
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordField{
            onLogin(self)
        }
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        return true
    }

}
