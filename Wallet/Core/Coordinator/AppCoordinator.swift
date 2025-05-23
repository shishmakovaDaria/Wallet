//
//  AppCoordinator.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    private let window: UIWindow?
    private let router: Router
    
    // MARK: - Life Cycle
    init(
        router: Router,
        window: UIWindow?
    ) {
        self.router = router
        self.window = window
        super.init()
    }
    
    // MARK: - Class methods
    class func build(
        router: Router,
        window: UIWindow?
    ) -> AppCoordinator {
        let appCoordinator = AppCoordinator(
            router: router,
            window: window
        )
        return appCoordinator
    }
    
    // MARK: - Private functions
    private func performMainFlow() {
        let coordinator = MainCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self, let coordinator else { return }
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}

// MARK: - Coordinator
extension AppCoordinator: Coordinator {
    func start() {
        performMainFlow()
        window?.makeKeyAndVisible()
    }
}
