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
    let currenciesSubject = CurrentValueSubject<[CryptoCurrency], Never>([])
    let isLoading = PassthroughSubject<Bool, Never>()
    let errorSubject = PassthroughSubject<String, Never>()
    
    // MARK: - Services
    private let currencyService: CryptoCurrencyServiceProtocol
    
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
                self.currenciesSubject.value = currencies
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
}
