//
//  SignUp.swift
//  newsApplication
//
//  Created by Nidhishree on 04/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var didTapButtonText: UIButton!
    var authViewModel = AuthViewModel()
    
    var authType: AuthType = .signIn {
        didSet {
            authViewModel.getAuthData(authType: authType)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textChangeButton()
    }
    
    func textChangeButton() {
        if authType == .signUp {
            didTapButtonText.setTitle("Sign Up", for: .normal)
        } else if authType == .signIn {
            didTapButtonText.setTitle("Sign In", for: .normal)
        }
    }
    
    func presentNewsFeedVC() {
        guard  let newsFeed = UIStoryboard(name: "NewsFeed", bundle: nil).instantiateViewController(withIdentifier: "NewsFeedVC") as? NewsFeedVC else { return }
        self.navigationController?.pushViewController(newsFeed, animated: true)
    }
    
    @IBAction private func didTapLoginButton(_ sender: Any) {
        self.resignFirstResponder()
        if authType == .signIn {
            Auth.auth().signIn(withEmail: authViewModel.signInModel.email , password: authViewModel.signInModel.password) { (user, error) in
                if error == nil {
                   self.presentNewsFeedVC()
                    //let controller = storyboard?.instantiateViewController(withIdentifier: "NewsFeedVC") as? NewsFeedVC
                }
            }
        } else if authType == .signUp {
            Auth.auth().createUser(withEmail: authViewModel.signUpModel.email, password: authViewModel.signUpModel.password) { (user, error) in
                if error == nil {
                    self.presentNewsFeedVC()
                }
            }
        }
    }
}

extension SignUpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authViewModel.userDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let signUpCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SignUpCell.self), for: indexPath) as? SignUpCell {
            tableView.separatorStyle = .none
            signUpCell.titleLabel.text = authViewModel.userDataList[indexPath.row].title
            signUpCell.textField.placeholder = authViewModel.userDataList[indexPath.row].placeholdertext
            //signUpCell.titleLabel.tag = indexPath.row
            signUpCell.textField.delegate = self
            signUpCell.textField.tag = indexPath.row
            print(indexPath.row)
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
        case .confirmPassword:
            authViewModel.getConfirmPassword(confirmPasswordText: textField.text ?? "")
            }
        }
}
