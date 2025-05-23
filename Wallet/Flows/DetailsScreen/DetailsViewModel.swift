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
    let percentChangeSubject = PassthroughSubject<Double, Never>()
    
    // MARK: - Life Cycle
    init(currency: CryptoCurrency) {
        self.currencySubject = CurrentValueSubject<CryptoCurrency, Never>(currency)
    }
    
    // MARK: - Public methods
    func changeTimeInterval(_ timeInterval: TimeInterval) {
        let percent: Double
        switch timeInterval {
        case .day:
            percent = currencySubject.value.marketData.percentChangeUsdLast24Hours ?? 0
        case .oneHour:
            percent = currencySubject.value.marketData.percentChangeUsdLast1Hour ?? 0
        case .oneWeek:
            percent = currencySubject.value.roiData.percentChangeLast1Week ?? 0
        case .oneMonth:
            percent = currencySubject.value.roiData.percentChangeLast1Month ?? 0
        case .threeMonth:
            percent = currencySubject.value.roiData.percentChangeLast3Months ?? 0
        case .oneYear:
            percent = currencySubject.value.roiData.percentChangeLast1Year ?? 0
        }
        
        percentChangeSubject.send(percent)
    }
}
