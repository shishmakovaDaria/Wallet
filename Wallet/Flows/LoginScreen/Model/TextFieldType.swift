//
//  TextFieldType.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit

enum TextFieldType {
    case username
    case password
    
    var icon: UIImage {
        switch self {
        case .username:
            return UIImage(resource: .user)
        case .password:
            return UIImage(resource: .password)
        }
    }
    
    var title: String {
        switch self {
        case .username:
            return LocalizableStrings.username
        case .password:
            return LocalizableStrings.password
        }
    }
}
