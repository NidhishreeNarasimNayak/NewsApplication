//
//  ViewController.swift
//  newsApplication
//
//  Created by Nidhishree on 03/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit
import GoogleSignIn
/// class is used handle googleSignIn procedure
class ViewController: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        FireBaseConfig.shared.googleSignInHandler = { ( isSucess: Bool) -> Void in
            print(isSucess)
        }
    }
    
    // MARK: - IBAction
    @IBAction private func googleSignIn(_ sender: Any) {
        //startSpinning()
        GIDSignIn.sharedInstance()?.signIn()
       }
    
    // MARK: - IBAction
    @IBAction private func createNewAccount(_ sender: Any) {
       navigateToSIgnUpVC(authType: .signUp)
    }
    
   // MARK: - IBAction
    @IBAction private func signInAction(_ sender: Any) {
      navigateToSIgnUpVC(authType: .signIn)
    }
    
    /// this method is to navigate to the next viewController which is SignUpVC
    ///
    /// - Parameter authType: there are two types of login procedures. This includes signup and signin. Therefore authType is used to switch between signUp and signIn.
    func navigateToSIgnUpVC(authType: AuthType) {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: NavigateToVc.signUpVc) as? SignUpVC else {
            return
        }
        signUpVC.authViewModel.authType = authType
        let navigationControllerSignUpVC = UINavigationController(rootViewController: signUpVC)
        stopSpinning()
        self.present(navigationControllerSignUpVC,animated: true,completion: nil)
        navigationControllerSignUpVC.navigationBar.barTintColor = UIColor().getOrange()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        if signUpVC.authViewModel.authType == .signIn {
            signUpVC.title = LoginMethodsTitle.signIn
            navigationControllerSignUpVC.navigationBar.titleTextAttributes = textAttributes
        } else if signUpVC.authViewModel.authType == .signUp {
           signUpVC.title = LoginMethodsTitle.signUp
             navigationControllerSignUpVC.navigationBar.titleTextAttributes = textAttributes
        }
    }
    
}
