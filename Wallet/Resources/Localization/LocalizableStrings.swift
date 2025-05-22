//
//  LocalizableStrings.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import Foundation

struct LocalizableStrings {
    
    // MARK: - login screen
    static let login = NSLocalizedString("login", comment: "Login button title")
    static let username = NSLocalizedString("username", comment: "Username text field placeholder")
    static let password = NSLocalizedString("password", comment: "Password text field placeholder")
    
    // MARK: - login alert
    static let error = NSLocalizedString("error", comment: "Error alert title")
    static let incorrectName = NSLocalizedString("incorrectName", comment: "Incorrect username alert message")
    static let repeatMessage = NSLocalizedString("repeatMessage", comment: "Repeat alert button")
    static let cancel = NSLocalizedString("cancel", comment: "Cancel alert button")
}
