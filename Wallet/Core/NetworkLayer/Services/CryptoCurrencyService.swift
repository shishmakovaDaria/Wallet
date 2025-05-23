//
//  CryptoCurrencyService.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import Foundation

protocol CryptoCurrencyServiceProtocol {
    func getCryptoCurrencies() async throws -> [CryptoCurrency]
    func getSingleCryptoCurrency(symbol: String) async throws -> CryptoCurrency
}

struct CryptoCurrencyService: CryptoCurrencyServiceProtocol {
    
    // MARK: - Constants
    enum Constants {
        static let currenciesSymbols = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    }

    // MARK: - Properties
    private let networkClient: NetworkClientProtocol
    
    // MARK: - Life Cycle
    init(networkClient: NetworkClientProtocol = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: - Public methods
    func getCryptoCurrencies() async throws -> [CryptoCurrency] {
        try await withThrowingTaskGroup(of: (Int, CryptoCurrency).self) { group in
            for (index, symbol) in Constants.currenciesSymbols.enumerated() {
                group.addTask {
                    let currency = try await self.getSingleCryptoCurrency(symbol: symbol)
                    return (index, currency)
                }
            }

            var results: [(Int, CryptoCurrency)] = []

            for try await result in group {
                results.append(result)
            }

            return results.sorted { $0.0 < $1.0 }.map { $0.1 }
        }
    }

    func getSingleCryptoCurrency(symbol: String) async throws -> CryptoCurrency {
        let getCryptoCurrencyRequest = CryptoCurrencyRequest(currencySymbol: symbol)
        let response = try await networkClient.send(request: getCryptoCurrencyRequest, type: CryptoCurrencyResponse.self)
        
        return response.data
    }
}
