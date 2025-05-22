//
//  LoginViewModel.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import Foundation
import Combine

final class LoginViewModel {
    
    // MARK: - Closures
    var onHomeScreen: (() -> Void)?
    
    // MARK: - Publishers
    let loginButtonIsEnabled = CurrentValueSubject<Bool, Never>(false)
    let errorSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - Private properties
    private var username = ""
    private var password = ""
    
    // MARK: - Public methods
    func usernameChanged(_ text: String) {
        username = text
        
        loginButtonIsEnabled.send(username != "" && password != "")
    }
    
    func passwordChanged(_ text: String) {
        password = text
        
        loginButtonIsEnabled.send(username != "" && password != "")
    }
    
    func clearTextFields() {
        username = ""
        password = ""
        
        loginButtonIsEnabled.send(false)
    }
    
    func loginTapped() {
        if username == "1234" && password == "1234" {
            onHomeScreen?()
            //todo save to userDefaults
        } else {
            errorSubject.send()
        }
    }
}
