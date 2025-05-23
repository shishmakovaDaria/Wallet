//
//  CryptoCurrencyService.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import Foundation

protocol CryptoCurrencyServiceProtocol {
    func getCryptoCurrency(symbol: String) async throws -> CryptoCurrency
}

struct CryptoCurrencyService: CryptoCurrencyServiceProtocol {

    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    func getCryptoCurrency(symbol: String) async throws -> CryptoCurrency {
        let getCryptoCurrencyRequest = CryptoCurrencyRequest(currencySymbol: symbol)
        let response = try await networkClient.send(request: getCryptoCurrencyRequest, type: CryptoCurrencyResponse.self)
        
        return response.data
    }
}
