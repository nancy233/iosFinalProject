//
//  LogInViewController.swift
//  Anime In Life
//
//  Created by nancy on 5/2/17.
//  Copyright © 2017 nan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            self.performSegue(withIdentifier: "LogInToMain", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func attemptLogin(_ sender: UIButton) {
        guard let emailText = emailField.text else { return }
        guard let passwordText = passwordField.text else { return }
        
        FIRAuth.auth()?.signIn(withEmail: emailText, password: passwordText, completion: {(user, error) in
            if let error = error{
                let myAlert = UIAlertController(title: "Login Failed",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
                myAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
            }
            else {self.performSegue(withIdentifier: "LogInToMain", sender: nil)}})
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}
