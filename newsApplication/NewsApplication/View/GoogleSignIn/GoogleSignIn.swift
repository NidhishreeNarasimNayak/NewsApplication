//  GoogleSignIn.swift
//  newsApplication
//
//  Created by Nidhishree on 03/09/19.
//  Copyright © 2019 YML. All rights reserved.
import UIKit
import Firebase
import GoogleSignIn
///class used to handle googleSignIn procedures and Firebase procedures
class FireBaseConfig: NSObject, GIDSignInDelegate {
    var googleSignInHandler: ((_ isSucess: Bool) -> Void)?
    static let shared = FireBaseConfig()
    
    private override init() {
        super.init() // to acccess the NSObject properties
    }
    /// function used to set the clientID and assigns the delegate property to class FirebaseConfig
    func googleSetUp() {
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
    }
    // MARK: - GoogleSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print(user?.profile.email ?? "")
        googleSignInHandler?(error == nil)
        guard let authentication = user?.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credentials) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
