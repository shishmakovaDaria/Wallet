//
//  MainTabBarController.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Life Cycle
    init(_ controllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        setupControllers(controllers)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.itemPositioning = .automatic
    }
    
    // MARK: - Private functions
    private func setupControllers(_ controllers: [UIViewController]) {
        let icons = [
            UIImage(resource: .home),
            UIImage(resource: .statistics),
            UIImage(resource: .wallet),
            UIImage(resource: .report),
            UIImage(resource: .profile)
        ]
        
        var tabs: [UIViewController] = []
        zip(controllers, icons).forEach { (vc, icon) in
            tabs.append(createViewController(controller: vc, image: icon))
        }
        
        viewControllers = tabs
    }
    
    private func createViewController(controller: UIViewController, image: UIImage?) -> UIViewController {
        let selectedImage = image?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.tabbarBlack)
        
        let unselectedImage = image?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.tabbarGray)
        
        controller.tabBarItem.image = unselectedImage
        controller.tabBarItem.selectedImage = selectedImage
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
        return controller
    }
}
