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
        UserDefaultsHelper.userIsLoggedIn ? runMainScreen() : runLoginScreen()
    }
    
    private func runLoginScreen() {
        let loginViewModel = LoginViewModel()
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        
        loginViewModel.onHomeScreen = { [weak self] in
            self?.runMainScreen()
        }
        
        router.setRootController(loginViewController)
    }
    
    private func runMainScreen() {
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        homeViewModel.onLoginScreen = { [weak self] in
            self?.runLoginScreen()
        }
        
        let statisticsViewController = UIViewController.coloredController(.cyan)
        let walletsViewController = UIViewController.coloredController(.purple)
        let reportViewController = UIViewController.coloredController(.gray)
        let profileViewController = UIViewController.coloredController(.red)
        
        let tabbar = MainTabBarController(
            [
                homeViewController,
                statisticsViewController,
                walletsViewController,
                reportViewController,
                profileViewController
            ]
        )
        router.setRootController(tabbar)
    }
}

// MARK: - Coordinator
extension MainCoordinator: Coordinator {
    func start() {
        performFlow()
    }
}
