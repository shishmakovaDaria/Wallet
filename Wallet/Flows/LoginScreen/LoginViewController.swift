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
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: .logo)
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    private lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .walletBlack
        configuration.baseForegroundColor = .white
        var container = AttributeContainer()
        container.font = UIFont.poppinsSemiBold(ofSize: 15.0)
        configuration.attributedTitle = AttributedString(LocalizableStrings.login, attributes: container)
        
        let loginButton = UIButton(configuration: configuration, primaryAction: nil)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return loginButton
    }()
    
    // MARK: - Properties
    private let viewModel: LoginViewModel
    
    // MARK: - Life Cycle
    init(viewModel: LoginViewModel) {
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
        view.backgroundColor = .walletGray
        
        [logoImageView, loginButton].forEach {
            view.addSubview($0)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(44.0)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(13.0)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(55.0)
            make.leading.trailing.equalToSuperview().inset(25.0)
            make.bottom.equalTo(-133.0)
        }
    }
    
    // MARK: - Actions
    @objc private func loginTapped() {
        //todo
    }
}
