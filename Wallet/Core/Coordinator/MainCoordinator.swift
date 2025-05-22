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
        //todo
        runLoginScreen()
    }
    
    private func runLoginScreen() {
        let loginViewModel = LoginViewModel()
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        
        router.setRootController(loginViewController)
    }
    
    private func runHomeScreen() {
        
    }
}

// MARK: - Coordinator
extension MainCoordinator: Coordinator {
    func start() {
        performFlow()
    }
}
