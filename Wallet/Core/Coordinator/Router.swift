//
//  Router.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit

final class Router {
    
    // MARK: - Properties
    private weak var rootController: UINavigationController?
    
    // MARK: - Life Cycle
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    // MARK: - Public methods
    func setRootController(_ controller: UIViewController, hideBar: Bool = true, animated: Bool = false) {
        rootController?.setViewControllers([controller], animated: animated)
        rootController?.isNavigationBarHidden = hideBar
        rootController?.modalPresentationStyle = .fullScreen
    }
    
    func push(_ controller: UIViewController, animated: Bool = true) {
        guard !(controller is UINavigationController) else { return }

        rootController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        rootController?.popViewController(animated: animated)
    }
    
    func present(_ controller: UIViewController, animated: Bool = true) {
        rootController?.present(controller, animated: animated)
    }
    
    func dismissController(animated: Bool = true, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
}
