//
//  SignUpModel.swift
//  newsApplication
//
//  Created by Nidhishree on 05/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import Foundation
//struct signUp {
//    let headerTextField: String
//    let userTextField: String
//}
enum signUp: Int {
    case headerTextField = 0
    case userTextField
    var description: String {
        switch self {
        case .headerTextField:
            return "email"
        case .userTextField:
            return "password"
        default: print("not valid")
        }
    }
    
}
