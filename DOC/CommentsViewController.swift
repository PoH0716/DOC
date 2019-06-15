//
//  CommentsViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/5/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit
import Firebase

class CommentsViewController: UIViewController, UITextViewDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        saveButton.layer.cornerRadius = 20
        
        self.commentText.delegate = self
        self.commentText.layer.borderWidth = 2.5
        self.commentText.layer.cornerRadius = 10;
        self.commentText.layer.borderColor = UIColor.gray.cgColor
        self.commentText.text = "Enter your comment here:"
        self.commentText.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentText.textColor == UIColor.lightGray {
            commentText.text = nil
            commentText.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentText.text.isEmpty {
            commentText.text = "Enter your comment here:"
            commentText.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let comments = commentText.text
        
        db.collection("Users/\(User.instance.userId!)/Dates/\(User.instance.getDate())/Comments").document("Comments on symptoms").setData(["entry": comments!], merge: true) {err in
            if let err = err {
                print("Error writing comments: \(err)")
            } else {
                print("Commented")
            }
        }
        
        let alert = UIAlertController(title: "Success", message: "Your comment has been saved and available for your doctor to view!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (err) in
            self.commentText.text = nil
            self.commentText.text = "Enter your comment here:"
            self.commentText.textColor = UIColor.lightGray
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
