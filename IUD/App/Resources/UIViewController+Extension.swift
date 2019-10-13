//
//  UIViewController+Extension.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

extension UIViewController {
    
    typealias MethodHandler = ()  -> Void
    
    /**
     Presenta un UIAlertController
     - parameter title: Título del UIAlertController
     - parameter message: Mensaje a mostrar
     */
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ALERT_OK", comment: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        alertController.preferredAction = okAction
        self.present(alertController, animated: true, completion: nil)
    }
    
    /**
     Presenta un UIAlertController
     - parameter title: Título del UIAlertController
     - parameter message: Mensaje a mostrar
     */
    func presentAlertAndGoBack(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ALERT_OK", comment: ""), style: .default) { (_) in
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(okAction)
        alertController.preferredAction = okAction
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlertTextfield(title: String, message: String, defaultTextValue: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = defaultTextValue
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("ALERT_OK", comment: ""), style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields?[0]
            print("Text field: \(textField?.text ?? "No name")")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
