//
//  DetailsViewModel.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import Foundation
import Combine

final class DetailsViewModel {
    
    // MARK: - Closures
    var onClose: (() -> Void)?
    
    // MARK: - Publishers
    let currencySubject: CurrentValueSubject<CryptoCurrency, Never>
    
    // MARK: - Life Cycle
    init(currency: CryptoCurrency) {
        self.currencySubject = CurrentValueSubject<CryptoCurrency, Never>(currency)
    }
}
