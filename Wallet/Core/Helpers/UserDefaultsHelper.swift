//
//  UserDefaultsHelper.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import Foundation

enum UserDefaultsKeys: String {
    case userIsLoggedIn = "userIsLoggedInKey"
    
    var asString: String {
        return self.rawValue
    }
}

struct UserDefaultsHelper {
    
    static var userIsLoggedIn: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKeys.userIsLoggedIn.asString) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userIsLoggedIn.asString) }
    }
}
