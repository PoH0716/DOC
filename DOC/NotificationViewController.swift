//
//  NotificationViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/30/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var medicationField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        self.medicationField.delegate = self
        setButton.layer.cornerRadius = 20
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("Yes")
            } else {
                print("No")
            }
        }
        
    }
    
    @IBAction func notification(_ sender: Any) {
        let medication = medicationField.text
        
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "It is time to take your \(medication!)!"
        let imageName = "dopaicon"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "PNG") else { return }
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        content.attachments = [attachment]
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "UYLDeleteAction", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: "UYLReminderCategory", actions: [snoozeAction,deleteAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = "UYLReminderCategory"
        
        let date = timePicker.date
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let request = UNNotificationRequest(identifier: "med.notification.01", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print("attempting to send notification")
    }
    
    // doesn't get called
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Foreground notification called")
        completionHandler([.alert, .badge, .sound])
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
