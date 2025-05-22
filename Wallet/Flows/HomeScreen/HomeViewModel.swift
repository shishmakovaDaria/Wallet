//
//  HomeViewModel.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Closures
    var onLoginScreen: (() -> Void)?
    
    // MARK: - Public methods
    func logoutUser() {
        UserDefaultsHelper.userIsLoggedIn = false
        onLoginScreen?()
    }
}
