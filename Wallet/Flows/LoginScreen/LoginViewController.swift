//
//  LoginViewController.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    // MARK: - UI
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup UI
    private func setupView() {
        view.backgroundColor = .walletGray
    }
}
