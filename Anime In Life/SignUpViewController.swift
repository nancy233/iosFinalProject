//
//  SignUpViewController.swift
//  Anime In Life
//
//  Created by nancy on 5/2/17.
//  Copyright © 2017 nan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func attemptSignUp(_ sender: UIButton) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let name = nameField.text else { return }
        
        let user = FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user, error) in
            if let error = error{
                let myAlert = UIAlertController(title: "Sign Up Failed",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
                myAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
            }
            else{
                let changeRequest = user?.profileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: {(err) in
                    if let err = err {
                        print(err)
                    }else{
                        self.performSegue(withIdentifier: "SignUpToMain", sender: nil)
                    }})
            }})

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
