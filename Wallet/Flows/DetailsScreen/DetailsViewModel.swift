//
//  DetailsViewModel.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import Foundation

final class DetailsViewModel {
    
    // MARK: - Closures
    var onClose: (() -> Void)?
    
    // MARK: - Life Cycle
    init(currency: CryptoCurrency) {
        print("DetailsViewModel init")
        print(currency)
    }
}
