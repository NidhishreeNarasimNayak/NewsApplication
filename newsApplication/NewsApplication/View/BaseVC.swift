//
//  Extension+UIViewController.swift
//  newsApplication
//
//  Created by Nidhishree on 11/09/19.
//  Copyright © 2019 YML. All rights reserved.
//

import Foundation
import UIKit

///class which contains instance of UIActivityIndicatorView
 class BaseVC:  UIViewController {
    var loadingIndicator = UIActivityIndicatorView()
}

// MARK: - UIActivityIndicatorView, UIAlertController
extension BaseVC {
    ///function which creates a loader and uses it when any background task happens
   public func startSpinning() {
        loadingIndicator.center = self.view.center
        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: view.frame.width / 2 - 25, y: view.frame.height / 2 - 25, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loadingIndicator.color = UIColor().getOrange()
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    //function used to stop animating the loader
   public func stopSpinning() {
        loadingIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    /// function used to create an alert view and add action to it
   public func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertMessages.alertActionTitle, style: UIAlertAction.Style.destructive, handler: nil))
         self.present(alert,animated: true,completion: nil)
    }
}
