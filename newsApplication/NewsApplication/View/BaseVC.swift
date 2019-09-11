//
//  Extension+UIViewController.swift
//  newsApplication
//
//  Created by Nidhishree on 11/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import Foundation
import UIKit

class BaseVC:  UIViewController {
    var loadingIndicator = UIActivityIndicatorView()
}
extension BaseVC {
    func startSpinning() {
        loadingIndicator.center = self.view.center
        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: view.frame.width / 2 - 25, y: view.frame.height / 2 - 25, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loadingIndicator.color = UIColor().getOrange()
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopSpinning() {
        loadingIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
          }))
         self.present(alert,animated: true,completion: nil)
    }
}
