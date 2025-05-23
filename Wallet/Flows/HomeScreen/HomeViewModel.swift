//
//  HomeViewModel.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import Foundation
import Combine

final class HomeViewModel {
    
    // MARK: - Closures
    var onLoginScreen: (() -> Void)?
    
    // MARK: - Publishers
    let sortedCurrenciesSubject = CurrentValueSubject<[CryptoCurrency], Never>([])
    let isLoading = PassthroughSubject<Bool, Never>()
    let errorSubject = PassthroughSubject<String, Never>()
    var selectedSortOption = CurrentValueSubject<SortOption, Never>(.none)
    
    // MARK: - Services
    private let currencyService: CryptoCurrencyServiceProtocol
    
    // MARK: - Private properties
    private var currencies: [CryptoCurrency] = []
    
    // MARK: - Life Cycle
    init(currencyService: CryptoCurrencyServiceProtocol = CryptoCurrencyService()) {
        self.currencyService = currencyService
    }
    
    // MARK: - Public methods
    func fetchCurrencies() {
        Task { [weak self] in
            guard let self else { return }
            
            self.isLoading.send(true)
            defer { self.isLoading.send(false) }
            
            do {
                let currencies = try await currencyService.getCryptoCurrencies()
                self.currencies = currencies
                sortHotels(by: selectedSortOption.value)
            } catch {
                let message: String

                switch error {
                case NetworkClientError.httpStatusCode(let code):
                    message = LocalizableStrings.serverError + " \(code)"
                case NetworkClientError.urlRequestError(let underlyingError):
                    message = [LocalizableStrings.requestError, underlyingError.localizedDescription].joined(separator: " ")
                case NetworkClientError.urlSessionError:
                    message = LocalizableStrings.networkError
                case NetworkClientError.parsingError:
                    message = LocalizableStrings.failedProcessData
                default:
                    message = LocalizableStrings.unknownError
                }

                self.errorSubject.send(message)
            }
        }
    }
    
    func logoutUser() {
        UserDefaultsHelper.userIsLoggedIn = false
        onLoginScreen?()
    }
    
    func sortHotels(by sortOption: SortOption) {
        selectedSortOption.value = sortOption
        
        switch sortOption {
        case .none:
            sortedCurrenciesSubject.value = currencies
        case .priceIncrease:
            sortedCurrenciesSubject.value = currencies.sorted { $0.marketData.priceUsd ?? 0 < $1.marketData.priceUsd ?? 0 }
        case .priceDecrease:
            sortedCurrenciesSubject.value = currencies.sorted { $0.marketData.priceUsd ?? 0 > $1.marketData.priceUsd ?? 0 }
        }
    }
}
