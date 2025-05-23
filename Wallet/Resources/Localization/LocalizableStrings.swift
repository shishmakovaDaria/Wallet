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
    
    // MARK: - home screen
    static let home = NSLocalizedString("home", comment: "Home screen title")
    static let affiliateProgram = NSLocalizedString("affiliateProgram", comment: "Affiliate program label")
    static let learnMore = NSLocalizedString("learnMore", comment: "Learn more button title")
    static let refresh = NSLocalizedString("refresh", comment: "Refresh menu title")
    static let logout = NSLocalizedString("logout", comment: "Logout menu title")
    static let trending = NSLocalizedString("trending", comment: "Trending label")
    static let priceIncrease = NSLocalizedString("priceIncrease", comment: "Price increase label")
    static let priceDecrease = NSLocalizedString("priceDecrease", comment: "Price decrease label")
    static let noneSorting = NSLocalizedString("noneSorting", comment: "Default sorting label")
    
    // MARK: - error
    static let unknownError = NSLocalizedString("unknownError", comment: "Unknown error text")
    static let failedProcessData = NSLocalizedString("failedProcessData", comment: "Failed process data error text")
    static let networkError = NSLocalizedString("networkError", comment: "Network error text")
    static let requestError = NSLocalizedString("requestError", comment: "Request error text")
    static let serverError = NSLocalizedString("serverError", comment: "Server error text")
}
