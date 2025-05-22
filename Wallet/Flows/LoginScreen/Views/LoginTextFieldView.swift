//
//  LoginTextFieldView.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 22.05.2025.
//

import UIKit
import SnapKit
import Combine

final class LoginTextFieldView: UIView {
    
    // MARK: - UI
    private lazy var icon = UIImageView()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.poppinsRegular(ofSize: 15.0)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        return textField
    }()
    
    // MARK: - Publishers
    let textFieldDidChanged = PassthroughSubject<String, Never>()
    
    // MARK: - Life Cycle
    init(_ type: TextFieldType) {
        super.init(frame: .zero)
        configure(type)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func textFieldChanged() {
        if let text = textField.text {
            textFieldDidChanged.send(text)
        }
    }
    
    // MARK: - Setup UI
    private func setupView() {
        backgroundColor = .white.withAlphaComponent(0.8)
        layer.cornerRadius = 27.5
        
        [icon, textField].forEach {
            addSubview($0)
        }
        
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(32.0)
            make.leading.equalTo(10.0)
            make.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(20.0)
        }
    }
    
    private func configure(_ type: TextFieldType) {
        icon.image = type.icon
        textField.placeholder = type.title
    }
}

//MARK: - UITextFieldDelegate
extension LoginTextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text {
            textFieldDidChanged.send(text)
        }
        
        return true
    }
}
