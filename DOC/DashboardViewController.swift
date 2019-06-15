//
//  DashboardViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/5/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit
import FirebaseUI

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onLogout(_ sender: Any) {
        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            
//            do {
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "userLoggedIn")
//            self.navigationController?.popToRootViewController(animated: true)
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            {
                self.present(vc, animated: true, completion: nil)
            }
//            } catch let error {
//                print("Failed to logout", error)
//            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alert = UIAlertController(title: "Signing Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true) {}
    }

}
