//
//  SignUp.swift
//  newsApplication
//
//  Created by Nidhishree on 04/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit
import Firebase
//class performs all operations on SignUpVC
class SignUpVC: UIViewController {
    
    @IBOutlet weak var didTapButtonText: UIButton!
    var authViewModel = AuthViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        textChangeButton()
    }
    
    /// function used to change the text of the button
    func textChangeButton() {
        if authViewModel.authType == .signUp {
            didTapButtonText.setTitle("Sign Up", for: .normal)
        } else if authViewModel.authType == .signIn {
            didTapButtonText.setTitle("Sign In", for: .normal)
        }
    }
    
    /// function used to navigate to my next ViewController NewsFeedVC
    func presentNewsFeedVC() {
        guard  let newsFeed = UIStoryboard(name: "NewsFeed", bundle: nil).instantiateViewController(withIdentifier: "NewsFeedVC") as? NewsFeedVC else { return }
        self.navigationController?.pushViewController(newsFeed, animated: true)
    }
    
    @IBAction private func didTapLoginButton(_ sender: Any) {
        view.endEditing(true)
        authViewModel.signUpOrSignIn {[weak self](error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.presentNewsFeedVC()
            }
        }
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

extension SignUpVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let fieldType = UserData(rawValue: textField.tag) else { return }
        switch fieldType {
        case .email:
            authViewModel.updateEmail(emailText: textField.text ?? "", authType: authViewModel.authType)
        case .password:
            authViewModel.updatePassword(passwordText: textField.text ?? "", authType: authViewModel.authType)
            view.endEditing(true)
        case .confirmPassword:
            authViewModel.getConfirmPassword(confirmPasswordText: textField.text ?? "")
        }
    }
}
