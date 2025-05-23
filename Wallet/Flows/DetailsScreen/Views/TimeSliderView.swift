//
//  TimeSliderView.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import UIKit
import SnapKit
import Combine

final class TimeSliderView: UIView {
    
    // MARK: - UI
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var buttons: [UIButton] = []
    
    // MARK: - Properties
    private var selectedButton: UIButton?
    
    // MARK: - Publishers
    let timeIntervalSelected = PassthroughSubject<TimeInterval, Never>()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func buttonTapped(_ sender: UIButton) {
        selectButton(sender)
        let timeInterval = TimeInterval.allCases[sender.tag]
        timeIntervalSelected.send(timeInterval)
    }
    
    // MARK: - Setup UI
    private func setupView() {
        backgroundColor = .detailsGray
        layer.cornerRadius = 28.0
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4.0)
        }
    }
    
    private func setupButtons() {
        for interval in TimeInterval.allCases {
            let button = UIButton(type: .system)
            button.setTitle(interval.rawValue, for: .normal)
            button.setTitleColor(.cryptoGray, for: .normal)
            button.titleLabel?.font = UIFont.poppinsMedium(ofSize: 14.0)
            button.backgroundColor = .clear
            button.layer.cornerRadius = 24.0
            button.tag = buttons.count
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        if buttons.count > 1 {
            selectButton(buttons[0])
        }
    }
    
    private func selectButton(_ button: UIButton) {
        selectedButton?.backgroundColor = .clear
        selectedButton?.setTitleColor(.cryptoGray, for: .normal)

        button.backgroundColor = .white
        button.setTitleColor(.walletBlack, for: .normal)
        selectedButton = button
    }
}
