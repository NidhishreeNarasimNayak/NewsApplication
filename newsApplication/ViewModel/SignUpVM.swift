//
//  SignUpVM.swift
//  newsApplication
//
//  Created by Nidhishree on 05/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import Foundation
///enum used to detect signup or signin login action
enum AuthType: Int {
    case signUp
    case signIn
    
    var dataSet: [UserData] {
        switch self {
        case .signUp:
            return [.email, .password, .confirmPassword]
        case .signIn:
            return [.email, .password]
        }
    }
}
/// enum used to take email, password and confirm password as input
enum UserData: Int {
    case email
    case password
    case confirmPassword
    
    var title: String {
        switch self {
        case .email:
            return "Email Id"
        case .password:
            return "Password"
        case .confirmPassword:
            return "Confirm password"
        }
    }
    var placeholdertext: String {
        switch self {
        case .email:
            return "Enter your email Address"
        case .password:
            return "Enter your Password"
        case .confirmPassword:
            return "Enter your confirmed password"
        }
    }
}

/// class used to get all the userdata and update it
class AuthViewModel {
    var signUpModel = SignupModel(email: "", password: "", confirmPassword: "")
    var signInModel = SignInModel(email: "", password: "")
    var userDataList: [UserData] = []
    /// function used get the data from the user for signup and signin
    func getAuthData(authType: AuthType) {
        userDataList = authType.dataSet
    }
    /// function used to set the email which is observed by the property observer
    func updateEmail(emailText: String, authType: AuthType) {
        signUpModel.email = emailText
        if authType == .signUp {
            signUpModel.email = emailText
        } else {
            signInModel.email = emailText
        }
    }
     /// function used to set the password which is observed by the property observer
    func updatePassword(passwordText: String, authType: AuthType) {
        if authType == .signUp {
            signUpModel.password = passwordText
        } else {
            signInModel.password = passwordText
        }
    }
     /// function used to set the confirm password which is observed by the property observer
    func getConfirmPassword(confirmPasswordText: String) {
        signUpModel.confirmPassword = confirmPasswordText
    }
}
