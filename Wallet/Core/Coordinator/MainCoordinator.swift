//
//  MainCoordinator.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    var finishFlow: (() -> Void)?
    private let router: Router
    
    // MARK: - Life Cycle
    init(
        router: Router
    ) {
        self.router = router
        super.init()
        start()
    }
    
    // MARK: - Private functions
    private func performFlow() {
        UserDefaultsHelper.userIsLoggedIn ? runHomeScreen() : runLoginScreen()
    }
    
    private func runLoginScreen() {
        let loginViewModel = LoginViewModel()
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        
        loginViewModel.onHomeScreen = { [weak self] in
            self?.runHomeScreen()
        }
        
        router.setRootController(loginViewController)
    }
    
    private func runHomeScreen() {
        let homeViewController = ViewController()
        
        router.setRootController(homeViewController)
    }
}

// MARK: - Coordinator
extension MainCoordinator: Coordinator {
    func start() {
        performFlow()
    }
}
