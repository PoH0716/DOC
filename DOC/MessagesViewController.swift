//
//  MessagesViewController.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/5/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.messageLabel.layer.borderWidth = 2.5
        self.messageLabel.layer.cornerRadius = 10;
        self.messageLabel.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        User.instance.getMessage(userCompletionHandler: { message, error in
            if let message = message {
                self.messageLabel.text = message
            }
        })
    }

}
