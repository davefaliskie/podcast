//
//  SignupViewController.swift
//  podcast
//
//  Created by David Faliskie on 7/18/18.
//  Copyright © 2018 David Faliskie. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
   
    @IBAction func didTapEmailSignup(_ sender: Any) {
      
        let email = emailField.text!
        let password = passwordField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let email = authResult?.user.email, error == nil else {
                // TODO: do something better with error
                self.statusLabel.text = error!.localizedDescription
                return
            }
            self.statusLabel.text = "\(email) created"
            
        }
        
    }
    
}
