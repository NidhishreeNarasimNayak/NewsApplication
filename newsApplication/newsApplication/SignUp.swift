//
//  SignUp.swift
//  newsApplication
//
//  Created by Nidhishree on 04/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import UIKit

class SignUp: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func SignUpButton(_ sender: Any) {
        //let ndex = IndexPath(row: 0, section: 0)
        // SignUpCell = tableview.c
    }
}

extension SignUp: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let signUpCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SignUpCell.self), for: indexPath) as? SignUpCell {
            tableView.separatorStyle = .none
            if indexPath.row == 0 {
                signUpCell.SignUpLabel.text = "Email"
            } else if indexPath.row == 1 {
                signUpCell.SignUpLabel.text = "Password"
            } else{
                signUpCell.SignUpLabel.text = "Confirm Password"
            }
            
            return signUpCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
