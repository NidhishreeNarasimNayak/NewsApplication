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
    
    @IBAction private func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction private func createNewAccount(_ sender: Any) {
        navigateToSIgnUpVC(authType: .signUp)  
    }
    
    @IBAction private func signInAction(_ sender: Any) {
        navigateToSIgnUpVC(authType: .signIn)
    }
    
    /// this method is to navigate to the next viewController which is SignUpVC
    ///
    /// - Parameter authType: there are two types of login procedures. This includes signup and signin. Therefore AUthType is used to swtch between signUp and signIn
    func navigateToSIgnUpVC(authType: AuthType) {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC else {
            return
        }
        signUpVC.authType = authType
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
