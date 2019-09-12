//
//  SignUp.swift
//  newsApplication
//
//  Created by Nidhishree on 04/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit
import Firebase

//class used to perform signIn and signUp actions
class SignUpVC: BaseVC {
    
    @IBOutlet weak var didTapButtonText: UIButton!
    var authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTapCancel()
        didTapTextChange()
    }
    
    /// function used to perform cancel action
    private func didTapCancel() {
        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancelImage"), style: .plain, target: self, action: #selector(performCancelAction))
        navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    /// function used to change the text of the button
    private func didTapTextChange() {
        if authViewModel.authType == .signUp {
            didTapButtonText.setTitle(LoginConstants.signUp, for: .normal)
        } else if authViewModel.authType == .signIn {
            didTapButtonText.setTitle(LoginConstants.signIn, for: .normal)
        }
    }
    
    /// function used to push a View Controller 
    private func presentNewsFeedVC() {
        guard  let newsFeed = UIStoryboard(name: StoryboardConstants.newsFeed, bundle: nil).instantiateViewController(withIdentifier: NavigationConstants.newsFeedVc) as? NewsFeedVC else { return }
        self.navigationController?.pushViewController(newsFeed, animated: true)
    }
    
    // MARK: - IBAction
    @IBAction private func didTapLoginButton(_ sender: Any) {
        startSpinning()
        view.endEditing(true)
        authViewModel.signUpOrSignIn {[weak self](error) in
            self?.stopSpinning()
            if let error = error {
                self?.createAlert(title: AlertMessageConstants.alertTitle, message: AlertMessageConstants.alertMessage)
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
            signUpCell.selectionStyle = .none
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
            authViewModel.updateEmail(emailText: textField.text ?? UserInputsConstants.userInput, authType: authViewModel.authType)
        case .password:
            authViewModel.updatePassword(passwordText: textField.text ?? UserInputsConstants.userInput, authType: authViewModel.authType)
            view.endEditing(true)
        case .confirmPassword:
            authViewModel.getConfirmPassword(confirmPasswordText: textField.text ?? UserInputsConstants.userInput)
        }
    }
}
