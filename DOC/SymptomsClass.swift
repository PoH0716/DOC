//
//  SymptomsClass.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/27/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Symptom {
    
    static let instance = Symptom()
    
    var description: String!
    
    let symptoms = [
        "Forgetfulness, disorientation in time and space",
        "Vivid dreaming",
        "Hallucinations",
        "Delusions and paranoia",
        "Depressed mood",
        "Anxious mood",
        "Apathy",
        "Features of dopamine dysregulation syndrome",
        "Nighttime sleep problems",
        "Daytime sleepiness",
        "Pain and other sensations",
        "Urinary problems",
        "Constipation problems",
        "Lightheadedness on standing",
        "Fatigue",
        "Speech: difficulty being understood",
        "Salivation and drooling",
        "Chewing and swallowing",
        "Cutting food",
        "Small handwriting",
        "Trouble getting dressed",
        "Trouble bathing or brushing teeth",
        "Trouble doing hobbies/activities",
        "Difficulties with turning in bed",
        "Tremor impact on activites",
        "Getting in and out of bed",
        "Walking, balance, falling",
        "Freezing",
        "Speech - volumn, diction",
        "Reduced facial expressions",
        "Rigidity",
        "Finger tapping",
        "Slowed hand movements",
        "Rapid alternating movements of hands (pronation-supination)",
        "Toe tapping",
        "Leg agility - slowed, early fatigue",
        "Difficulties with rising from chairs",
        "Gait - shuffling, walking with difficulty",
        "Freezing of gait",
        "Postural stability - difficulty recovering balance",
        "Posture - stooped",
        "Global spontaneity of movement - body bradykinesia, slowness",
        "Rest tremor",
        "Dyskinesia",
        "Motor fluctuation"
    ]
    
    let symptomCat = [
    "Activities of daily living",
    "Motor examination",
    "Motor complications",
    "Intellectual function, mood, behavior"
    ]
    
    let symptomCat0 = [
        "forgetfulness",
        "vividdreaming",
        "hallucinations",
        "delusionsparanoia",
        "depressed",
        "anxious",
        "apathy",
        "dds",
        "nightsleepprob",
        "daysleep",
        "pain",
        "urinaryprob",
        "constipationprob",
        "lightheadedness",
        "fatigue"
    ]
    
    let symptomCat1 = [
        "speechunderstood",
        "salivation",
        "chewswallow",
        "cutfood",
        "smallwriting",
        "dressing",
        "bathroom",
        "hobbies",
        "bedturning",
        "tremorimpact",
        "inoutbed",
        "balance",
        "freezing"
    ]
    
    let symptomCat2 = [
        "speechvolume",
        "facialexp",
        "rigidity",
        "fingertap",
        "slowhands",
        "rapidhands",
        "toetap",
        "legagility",
        "chairrise",
        "gait",
        "freezinggait",
        "posturestability",
        "posture",
        "gsm",
        "tremorrest"
    ]
    
    let symptomCat3 = [
        "dyskinesia",
        "motorfluctuations"
    ]
    
    private var db: Firestore!
    
    init() {
        self.description = nil
        self.db = Firestore.firestore()
    }
    
    func initDefaultSymptoms(success: @escaping () -> (), failure: @escaping () -> ()) {
        storeDefault(Category: symptomCat[0], Symptom: symptomCat0)
        storeDefault(Category: symptomCat[1], Symptom: symptomCat1)
        storeDefault(Category: symptomCat[2], Symptom: symptomCat2)
        storeDefault(Category: symptomCat[3], Symptom: symptomCat3)
    }
    
    func storeDefault(Category: String, Symptom: [String]) {
        var i = 0
        while i < Symptom.count {
            self.db.collection("Users/\(User.instance.userId!)/Default").document(Category).setData([Symptom[i]: 0
            ], merge: true) { (err) in
                if err != nil{
                    print("Couldn't initialize")
                }
                else{
                    print("Initializing")
                }
            }
            i += 1
        }
    }
    
    func saveDefault(Type: String, Category: String, Symptom: String, Severity: Int) {
        db.collection("Users/\(User.instance.userId!)/\(Type)").document(Category).setData([Symptom: Severity
        ], merge: true) {err in
            if let err = err {
                print("Error setting default symptom: \(err)")
            } else {
                print("Default symptom set")
            }
        }
    }

    func saveSymptom(Type: String, Category: String, Symptom: String, Severity: Int) {
        db.collection("Users/\(User.instance.userId!)/Dates/\(User.instance.getDate())/\(Type)").document(Category).setData([Symptom: Severity
        ], merge: true) {err in
            if let err = err {
                print("Error setting symptom: \(err)")
            } else {
                print("Symptom set")
            }
        }
    }
    
    func fetchDefault(userCompletionHandler: @escaping (Int?, Error?) -> Void) {
        db.collection("Users/\(User.instance.userId!)/Default").document(User.instance.selectedCategory!).getDocument { (document, err) in
            if let document = document, document.exists {
                let data = document.data()
                if let severity = data![User.instance.selectedSymptom] {
                    print("Calling handler with severity data")
                    userCompletionHandler(severity as? Int, nil)
                }
            } else {
                print("Calling handler without severity data")
                userCompletionHandler(0, nil)
            }
        }
    }
    
    func fetchSymptom(userCompletionHandler: @escaping (Int?, Error?) -> Void) {
        db.collection("Users/\(User.instance.userId!)/Dates/\(User.instance.getDate())/Symptoms").document(User.instance.selectedCategory!).getDocument { (document, err) in
            if let document = document, document.exists {
                let data = document.data()
                if let severity = data![User.instance.selectedSymptom] {
                    print("Calling handler with severity data")
                    userCompletionHandler(severity as? Int, nil)
                }
            } else {
                print("Calling handler without severity data")
                userCompletionHandler(0, nil)
            }
        }
    }
    
    func syncDefaultSymptom() {
        for name in Symptom.instance.symptomCat {
            db.collection("Users").document(User.instance.userId!).collection("Default").document(name).getDocument { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if let document = querySnapshot {
                        let data = document.data()
                        
                        let symptomsRef = self.db.collection("Users/\(User.instance.userId!)/Dates/\(User.instance.getDate())/Symptoms").document(name)
                        
                        symptomsRef.setData(data!)
                    }
                }
            }
        }
    }
    
}
