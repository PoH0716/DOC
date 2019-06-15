//
//  DefaultTableViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/27/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit
import Firebase

class DefaultTableViewController: UITableViewController {
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        User.instance.selectedType = "Default"
    }
    
    func setDefaultCheckmarks(Category: String, Symptom: [String], section: Int) {
        db.collection("Users/\(User.instance.userId!)/Default").document(Category).getDocument { (document, err) in
            if let document = document, document.exists {
                let data = document.data()
                var i = 0
                while i < Symptom.count {
                    let severity = data![Symptom[i]] as! Int
                    let row = i
                    let indexPath = IndexPath(row: row, section: section)
                    if severity != 0 {
                        self.tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                    } else {
                        self.tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                    }
                    i += 1
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Symptom.instance.symptomCat.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return Symptom.instance.symptomCat[1]
        case 2:
            return Symptom.instance.symptomCat[2]
        case 3:
            return Symptom.instance.symptomCat[3]
        default:
            return Symptom.instance.symptomCat[0]
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.gray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.darkGray
        header.textLabel?.font = UIFont.systemFont(ofSize: 15.0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return Symptom.instance.symptomCat1.count
        case 2:
            return Symptom.instance.symptomCat2.count
        case 3:
            return Symptom.instance.symptomCat3.count
        default:
            return Symptom.instance.symptomCat0.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var symptom: String! = nil
        
        switch indexPath.section {
        case 1:
            symptom = Symptom.instance.symptoms[indexPath.row + 15]
        case 2:
            symptom = Symptom.instance.symptoms[indexPath.row + 28]
        case 3:
            symptom = Symptom.instance.symptoms[indexPath.row + 43]
        default:
            symptom = Symptom.instance.symptoms[indexPath.row]
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = symptom
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25.0)

        setDefaultCheckmarks(Category: Symptom.instance.symptomCat[0], Symptom: Symptom.instance.symptomCat0, section: 0)
        setDefaultCheckmarks(Category: Symptom.instance.symptomCat[1], Symptom: Symptom.instance.symptomCat1, section: 1)
        setDefaultCheckmarks(Category: Symptom.instance.symptomCat[2], Symptom: Symptom.instance.symptomCat2, section: 2)
        setDefaultCheckmarks(Category: Symptom.instance.symptomCat[3], Symptom: Symptom.instance.symptomCat3, section: 3)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            User.instance.selectedCategory = Symptom.instance.symptomCat[1]
            switch indexPath.row {
            case 1:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[1]
                Symptom.instance.description = Symptom.instance.symptoms[16]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 2:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[2]
                Symptom.instance.description = Symptom.instance.symptoms[17]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 3:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[3]
                Symptom.instance.description = Symptom.instance.symptoms[18]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 4:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[4]
                Symptom.instance.description = Symptom.instance.symptoms[19]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 5:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[5]
                Symptom.instance.description = Symptom.instance.symptoms[20]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 6:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[6]
                Symptom.instance.description = Symptom.instance.symptoms[21]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 7:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[7]
                Symptom.instance.description = Symptom.instance.symptoms[22]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 8:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[8]
                Symptom.instance.description = Symptom.instance.symptoms[23]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 9:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[9]
                Symptom.instance.description = Symptom.instance.symptoms[24]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 10:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[10]
                Symptom.instance.description = Symptom.instance.symptoms[25]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 11:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[11]
                Symptom.instance.description = Symptom.instance.symptoms[26]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 12:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[12]
                Symptom.instance.description = Symptom.instance.symptoms[27]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            default:
                User.instance.selectedSymptom = Symptom.instance.symptomCat1[0]
                Symptom.instance.description = Symptom.instance.symptoms[15]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            }
        case 2:
            User.instance.selectedCategory = Symptom.instance.symptomCat[2]
            switch indexPath.row {
            case 1:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[1]
                Symptom.instance.description = Symptom.instance.symptoms[29]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 2:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[2]
                Symptom.instance.description = Symptom.instance.symptoms[30]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 3:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[3]
                Symptom.instance.description = Symptom.instance.symptoms[31]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 4:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[4]
                Symptom.instance.description = Symptom.instance.symptoms[32]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 5:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[5]
                Symptom.instance.description = Symptom.instance.symptoms[33]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 6:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[6]
                Symptom.instance.description = Symptom.instance.symptoms[34]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 7:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[7]
                Symptom.instance.description = Symptom.instance.symptoms[35]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 8:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[8]
                Symptom.instance.description = Symptom.instance.symptoms[36]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 9:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[9]
                Symptom.instance.description = Symptom.instance.symptoms[37]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 10:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[10]
                Symptom.instance.description = Symptom.instance.symptoms[38]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 11:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[11]
                Symptom.instance.description = Symptom.instance.symptoms[39]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 12:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[12]
                Symptom.instance.description = Symptom.instance.symptoms[40]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 13:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[13]
                Symptom.instance.description = Symptom.instance.symptoms[41]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 14:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[14]
                Symptom.instance.description = Symptom.instance.symptoms[42]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            default:
                User.instance.selectedSymptom = Symptom.instance.symptomCat2[0]
                Symptom.instance.description = Symptom.instance.symptoms[28]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            }
        case 3:
            User.instance.selectedCategory = Symptom.instance.symptomCat[3]
            switch indexPath.row {
            case 1:
                User.instance.selectedSymptom = Symptom.instance.symptomCat3[1]
                Symptom.instance.description = Symptom.instance.symptoms[43]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            default:
                User.instance.selectedSymptom = Symptom.instance.symptomCat3[0]
                Symptom.instance.description = Symptom.instance.symptoms[44]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            }
        default:
            User.instance.selectedCategory = Symptom.instance.symptomCat[0]
            switch indexPath.row {
            case 1:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[1]
                Symptom.instance.description = Symptom.instance.symptoms[1]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 2:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[2]
                Symptom.instance.description = Symptom.instance.symptoms[2]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 3:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[3]
                Symptom.instance.description = Symptom.instance.symptoms[3]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 4:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[4]
                Symptom.instance.description = Symptom.instance.symptoms[4]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 5:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[5]
                Symptom.instance.description = Symptom.instance.symptoms[5]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 6:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[6]
                Symptom.instance.description = Symptom.instance.symptoms[6]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 7:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[7]
                Symptom.instance.description = Symptom.instance.symptoms[7]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 8:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[8]
                Symptom.instance.description = Symptom.instance.symptoms[8]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 9:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[9]
                Symptom.instance.description = Symptom.instance.symptoms[9]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 10:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[10]
                Symptom.instance.description = Symptom.instance.symptoms[10]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 11:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[11]
                Symptom.instance.description = Symptom.instance.symptoms[11]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 12:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[12]
                Symptom.instance.description = Symptom.instance.symptoms[12]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 13:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[13]
                Symptom.instance.description = Symptom.instance.symptoms[13]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            case 14:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[14]
                Symptom.instance.description = Symptom.instance.symptoms[14]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            default:
                User.instance.selectedSymptom = Symptom.instance.symptomCat0[0]
                Symptom.instance.description = Symptom.instance.symptoms[0]
                self.performSegue(withIdentifier: "setDefault", sender: nil)
            }
        }
    }
    
}
