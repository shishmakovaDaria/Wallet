//
//  DetailsViewController.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import UIKit
import SnapKit

final class DetailsViewController: UIViewController {
    
    // MARK: - UI
    
    // MARK: - Properties
    private let viewModel: DetailsViewModel
    
    // MARK: - Life Cycle
    init(viewModel: DetailsViewModel) {
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
        view.backgroundColor = .red
    }
}
