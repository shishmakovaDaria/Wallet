//
//  CryptoCurrencyRequest.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import Foundation

struct CryptoCurrencyRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://data.messari.io/api/v1/assets/\(currencySymbol)/metrics")
    }
    
    var currencySymbol: String
    
    init(currencySymbol: String) {
        self.currencySymbol = currencySymbol
    }
}
