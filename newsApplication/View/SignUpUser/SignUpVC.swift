//
//  SignUp.swift
//  newsApplication
//
//  Created by Nidhishree on 04/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    var authViewModel = AuthViewModel()
    var authType: AuthType = .signIn {
        didSet {
            authViewModel.getAuthData(authType: authType)
        }
    }
      override func viewDidLoad() {
        super.viewDidLoad()
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
            return signUpCell
        }
        return UITableViewCell()
    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
