//
//  SceneDelegate.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 21.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?
    
    var rootController: UINavigationController {
        window?.rootViewController = UINavigationController()
        guard let controller = window?.rootViewController as? UINavigationController
        else { return UINavigationController() }
        return controller
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = self.window ?? UIWindow(windowScene: windowScene)
        
        appCoordinator = AppCoordinator.build(
            router: Router(rootController: rootController),
            window: window
        )
        
        appCoordinator?.start()
    }
}
