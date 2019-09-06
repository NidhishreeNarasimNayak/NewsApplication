//
//  SignUpVM.swift
//  newsApplication
//
//  Created by Nidhishree on 05/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import Foundation
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
//for signin and signup
enum UserData {
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

class AuthViewModel {
    var signUpModel: SignupModel?
    var signInModel: SignInModel?
    var userDataList: [UserData] = []
    func getAuthData(authType: AuthType) {
        //let signInModel = SignInModel(email: <#T##String#>, password: <#T##String#>)
        userDataList = authType.dataSet
    }
}
