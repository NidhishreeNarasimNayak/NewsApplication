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
    
    /// This is a property observer which observes which property is changed (signup or Signin)
    var authType: AuthType = .signIn {
        didSet {
            authViewModel.getAuthData(authType: authType)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textChangeButton()
}
    
    /// function used to change the text of the button
    func textChangeButton() {
        if authType == .signUp {
            didTapButtonText.setTitle("Sign Up", for: .normal)
        } else if authType == .signIn {
            didTapButtonText.setTitle("Sign In", for: .normal)
        }
    }
    
    /// function used to navigate to my next VIewController NewsFeedVC
    func presentNewsFeedVC() {
        guard  let newsFeed = UIStoryboard(name: "NewsFeed", bundle: nil).instantiateViewController(withIdentifier: "NewsFeedVC") as? NewsFeedVC else { return }
        //self.navigationController?.pushViewController(newsFeed, animated: true)
      //  self.presentingViewController?.dismiss(animated: false, completion:nil)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
//    func addBottomBorder(){
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect.init(x: 0, y: frame.size.height - 1, width: self.frame.size.width, height: 1)
//        bottomLine.backgroundColor = UIColor.white.cgColor
//        self.borderStyle = .none
//        self.layer.addSublayer(bottomLine)
//
//    }
    
    @IBAction private func didTapLoginButton(_ sender: Any) {
        view.endEditing(true)
        if authType == .signIn {
            Auth.auth().signIn(withEmail: authViewModel.signInModel.email , password: authViewModel.signInModel.password) { (_, error) in
                if error == nil {
                   self.presentNewsFeedVC()
                }
            }
        } else if authType == .signUp {
            Auth.auth().createUser(withEmail: authViewModel.signUpModel.email, password: authViewModel.signUpModel.password) { (_, error) in
                if error == nil {
                    self.presentNewsFeedVC()
                }
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
        //   print(textField.text, UserData(rawValue: textField.tag))
        guard let fieldType = UserData(rawValue: textField.tag) else { return }
        switch fieldType {
        case .email:
            authViewModel.updateEmail(emailText: textField.text ?? "", authType: authType)
        case .password:
            authViewModel.updatePassword(passwordText: textField.text ?? "", authType: authType)
            view.endEditing(true)
        case .confirmPassword:
            authViewModel.getConfirmPassword(confirmPasswordText: textField.text ?? "")
            }
        }
}
