//
//  UIViewController+Ext.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, with message: String, completion: @escaping()->()) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let repeatAction = UIAlertAction(
            title: LocalizableStrings.repeatMessage,
            style: .default
        ) { _ in
            completion()
        }
        
        let cancelAction = UIAlertAction(
            title: LocalizableStrings.cancel,
            style: .default
        )
        
        alertController.addAction(repeatAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
