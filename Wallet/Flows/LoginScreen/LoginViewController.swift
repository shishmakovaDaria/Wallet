//
//  LoginViewController.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit
import SnapKit
import Combine

final class LoginViewController: UIViewController {
    
    // MARK: - UI
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: .logo)
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    private lazy var usernameTextField = LoginTextFieldView(.username)
    private lazy var passwordTextField = LoginTextFieldView(.password)
    private lazy var textFieldsView = UIView()
    
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
    private var fieldsBottomConstraint: Constraint?
    private var bag = Set<AnyCancellable>()
    
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
        binding()
    }
    
    // MARK: - Actions
    @objc private func loginTapped() {
        viewModel.loginTapped()
    }
    
    // MARK: - Binding
    private func binding() {
        let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height }

        let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] keyboardHeight in
                guard let self else { return }
                let offset = keyboardHeight > 0 ? -keyboardHeight - 12 : -213
                self.fieldsBottomConstraint?.update(offset: offset)
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
            .store(in: &bag)
        
        viewModel.loginButtonIsEnabled
            .sink { [weak self] isEnabled in
                self?.loginButton.isEnabled = isEnabled
                self?.loginButton.configuration?.baseBackgroundColor = isEnabled ? .walletBlack : .walletBlack.withAlphaComponent(0.4)
            }
            .store(in: &bag)
        
        usernameTextField.textFieldDidChanged
            .sink { [weak self] name in
                self?.viewModel.usernameChanged(name)
            }
            .store(in: &bag)
        
        passwordTextField.textFieldDidChanged
            .sink { [weak self] password in
                self?.viewModel.passwordChanged(password)
            }
            .store(in: &bag)
    }
    
    // MARK: - Setup UI
    private func setupView() {
        view.backgroundColor = .walletGray
        
        [logoImageView, textFieldsView, loginButton].forEach {
            view.addSubview($0)
        }
        
        [usernameTextField, passwordTextField].forEach {
            textFieldsView.addSubview($0)
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
        
        textFieldsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25.0)
            self.fieldsBottomConstraint = make.bottom.equalTo(-213.0).constraint
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(loginButton)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(passwordTextField.snp.top).offset(-15.0)
            make.height.equalTo(loginButton)
        }
    }
}
