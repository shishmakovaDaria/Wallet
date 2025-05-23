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
    
    func showNetworkAlert(title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    static func coloredController(_ color: UIColor) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = color
        return controller
    }
}
