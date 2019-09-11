//
//  SignUp.swift
//  newsApplication
//
//  Created by Nidhishree on 04/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit
import Firebase
//class used to change the text of a button, navigate to the next ViewController
class SignUpVC: BaseVC {
    
    @IBOutlet weak var didTapButtonText: UIButton!
    var authViewModel = AuthViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
      cancelNavigationScreen()
        textChangeButton()
    }
    
    /// Description
   private func cancelNavigationScreen() {
    let cancelButton = UIBarButtonItem(image: UIImage(named: "cancelImage"), style: .plain, target: self, action: #selector(performCancelAction))
        //self.navigationItem.leftItemsSupplementBackButton = true
   // let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.red]
    navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    /// function used to change the text of the button
  private func textChangeButton() {
        if authViewModel.authType == .signUp {
            didTapButtonText.setTitle(LoginMethods.signUp, for: .normal)
        } else if authViewModel.authType == .signIn {
            didTapButtonText.setTitle(LoginMethods.signIn, for: .normal)
        }
    }
    
    /// function used to navigate to my next ViewController NewsFeedVC
    private func presentNewsFeedVC() {
        guard  let newsFeed = UIStoryboard(name: NavigateToStoryboard.newsFeed, bundle: nil).instantiateViewController(withIdentifier: NavigateToVc.newsFeedVc) as? NewsFeedVC else { return }
        self.navigationController?.pushViewController(newsFeed, animated: true)
    }
    
    // MARK: - IBAction
    @IBAction private func didTapLoginButton(_ sender: Any) {
        startSpinning()
        view.endEditing(true)
        authViewModel.signUpOrSignIn {[weak self](error) in
            self?.stopSpinning()
            if let error = error {
                
                print(error.localizedDescription)
            } else {
                self?.presentNewsFeedVC()
            }
        }
    }
    
    @objc private func performCancelAction(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SignUpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authViewModel.userDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let signUpCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SignUpCell.self), for: indexPath) as? SignUpCell {
            tableView.separatorStyle = .none
            signUpCell.titleLabel.text = authViewModel.userDataList[indexPath.row].title
            signUpCell.textField.placeholder = authViewModel.userDataList[indexPath.row].placeholdertext
            signUpCell.textField.delegate = self
            signUpCell.textField.tag = indexPath.row
            signUpCell.textField.borderStyle = .none
            signUpCell.textField.isSecureTextEntry = false
            if (signUpCell.textField.tag == 1) || ( signUpCell.textField.tag == 2) {
                signUpCell.textField.isSecureTextEntry = true
            }
            return signUpCell
        }
        return UITableViewCell()
    }
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
// MARK: - UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let fieldType = UserData(rawValue: textField.tag) else { return }
        switch fieldType {
        case .email:
            authViewModel.updateEmail(emailText: textField.text ?? UserInputs.userInput, authType: authViewModel.authType)
        case .password:
            authViewModel.updatePassword(passwordText: textField.text ?? UserInputs.userInput, authType: authViewModel.authType)
            view.endEditing(true)
        case .confirmPassword:
            authViewModel.getConfirmPassword(confirmPasswordText: textField.text ?? UserInputs.userInput)
        }
    }
}
