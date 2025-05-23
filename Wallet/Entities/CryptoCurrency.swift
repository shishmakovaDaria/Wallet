//
//  CryptoCurrency.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import Foundation

struct CryptoCurrencyResponse: Codable {
    let data: CryptoCurrency
}

struct CryptoCurrency: Codable, Hashable {
    let id: String
    let symbol: String
    let name: String
    let marketData: MarketData
    let marketcap: MarketcapData
    let supply: SupplyData
}

struct MarketData: Codable, Hashable {
    let priceUsd: Double?
    let percentChangeUsdLast24Hours: Double?
}

struct MarketcapData: Codable, Hashable {
    let currentMarketcapUsd: Double?
}

struct SupplyData: Codable, Hashable {
    let circulating: Double?
}
