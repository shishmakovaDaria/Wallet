//
//  HomeViewController.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit
import SnapKit
import Combine

final class HomeViewController: UIViewController {
    
    // MARK: - UI
    
    // MARK: - Properties
    private let viewModel: HomeViewModel
    
    // MARK: - Life Cycle
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup UI
    private func setupView() {
        view.backgroundColor = .walletPink
    }
}
