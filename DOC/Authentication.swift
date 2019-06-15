//
//  Authentication.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/26/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

let global_dispatchGroup = DispatchGroup()
func run(completion: @escaping() -> Void)
{
    DispatchQueue.main.async{
        completion()
    }
}

class Authenticate {
    static let instance = Authenticate()

    var registration_isValid:Bool = false
    
    func userRegistration(theEmail: String, thePassword: String, success: @escaping () -> (), failure: @escaping () -> ()) {
        Auth.auth().createUser(withEmail: theEmail, password: thePassword) { (user, error) in
            if let error = error{
                print(error.localizedDescription)
                failure()
            }
            else{
                print("auth success")
                if let _ = Auth.auth().currentUser{
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if let _ = error{
                            failure()
                        }
                        else{
                            success()
                        }
                    })
                }
                else{
                    failure()
                }
            }
        }
    }
    
    func userLogin(theEmail: String, thePassword: String, success: @escaping () -> (), failure: @escaping () -> ()) {
        Auth.auth().signIn(withEmail: theEmail, password: thePassword) { (user, error) in
            if let _ = error{
                failure()
            }
            else{
                print("auth success")
                if let user = Auth.auth().currentUser{
                    if !user.isEmailVerified{
                        failure()
                    }
                    else {
                        success()
                    }
                }
            }
        }
    }
    
    func passwordReset(theEmail: String, success: @escaping () -> (), failure: @escaping () -> ()) {
        Auth.auth().sendPasswordReset(withEmail: theEmail) { (error) in
            if error != nil{
                failure()
            }
            else{
                success()
            }
        }
    }
}
