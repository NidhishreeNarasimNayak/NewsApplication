//
//  ViewController.swift
//  newsApplication
//
//  Created by Nidhishree on 03/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        FireBaseConfig.shared.googleSignInHandler = { ( isSucess: Bool) -> Void in
            print(isSucess)
        }
    }
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    @IBAction func createNewAccount(_ sender: Any) {
        navigateToSIgnUpVC(authType: .signUp)
    }
    @IBAction func signInAction(_ sender: Any) {
        navigateToSIgnUpVC(authType: .signIn)
    }
    func navigateToSIgnUpVC(authType: AuthType) {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC else {
            return
        }
        signUpVC.authType = authType
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
