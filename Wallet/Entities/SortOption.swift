//
//  SortOption.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import Foundation

enum SortOption {
    case none
    case priceIncrease
    case priceDecrease
    
    var title: String {
        switch self {
        case .none:
            LocalizableStrings.noneSorting
        case .priceIncrease:
            LocalizableStrings.priceIncrease
        case .priceDecrease:
            LocalizableStrings.priceDecrease
        }
    }
}
