//
//  SignInManual.swift
//  newsApplication
//
//  Created by Nidhishree on 04/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit
import Firebase

class SignInManual: UIViewController {
    
    @IBOutlet weak var emailManual: UITextField!
    @IBOutlet weak var passwordManual: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignInManualLogin(_ sender: Any) {
        let email = emailManual.text ?? ""
        let password = passwordManual.text ?? ""
        Auth.auth().createUser(withEmail: email, password: password) { (user , signUperror) in
            if signUperror == nil {
                print("Creating new account and signing in. User not present")
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    print("user")
                })
            }
            else{
                print(signUperror?.localizedDescription ?? "Account present")
            }
        }
    }
}
