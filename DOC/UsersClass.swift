//
//  UsersClass.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/26/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import Foundation
import FirebaseFirestore

class User {
    
    static let instance = User()
    
    var userId: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    var password: String!
    var doctor: String!
    var selectedCategory: String!
    var selectedSymptom: String!
    var selectedType: String!
    var message: String!
    var severity: Int!
    var doctorId: Int!

    
    private var db: Firestore!
    
    init() {
        self.userId = nil
        self.firstName = nil
        self.lastName = nil
        self.email = nil
        self.password = nil
        self.doctor = nil
        self.selectedCategory = nil
        self.selectedSymptom = nil
        self.selectedType = nil
        self.severity = nil
        self.doctorId = nil
        self.db = Firestore.firestore()
    }
    
    func storeUserInfo(success: @escaping () -> (), failure: @escaping () -> ()){
        self.db.collection("Users").document(self.userId).setData([
            "First Name": self.firstName!,
            "Last Name": self.lastName!,
            "Email": self.email!,
            "Password": self.password!,
            "Doctor": self.doctor!,
            "DoctorId": self.doctorId!
        ], merge: true) { (err) in
            if err != nil{
                failure()
            }
            else{
                success()
            }
        }
    }
    
    func registerUser(success: @escaping () -> (), failure: @escaping () -> ()){
        Authenticate.instance.userRegistration(theEmail: self.email, thePassword: self.password, success: {
            print("user success")
            success()
        }) {
            print("user fail")
            failure()
        }
    }
    
    func getDate() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        
        return day+100*month+10000*year
    }
    
    func getMessage(userCompletionHandler: @escaping (String?, Error?) -> Void){
        db.collection("Users/\(userId!)/Dates/\(getDate())/Messages").document("Message from doctor").getDocument { (document, err) in
            if let document = document, document.exists {
                let data = document.data()
                if let message = data!["Message"] {
                    print("Message retrieved")
                    userCompletionHandler(message as? String, nil)
                }
            } else {
                print("No messages")
                userCompletionHandler(nil, nil)
            }
        }
    }
            
//            func fetchSymptom(userCompletionHandler: @escaping (Int?, Error?) -> Void) {
//                db.collection("Users/\(User.instance.userId!)/Dates/\(User.instance.getDate())/Symptoms").document(User.instance.selectedCategory!).getDocument { (document, err) in
//                    if let document = document, document.exists {
//                        let data = document.data()
//                        if let severity = data![User.instance.selectedSymptom] {
//                            print("Calling handler with severity data")
//                            userCompletionHandler(severity as? Int, nil)
//                        }
//                    } else {
//                        print("Calling handler without severity data")
//                        userCompletionHandler(0, nil)
//                    }
//                }
//            }
}
