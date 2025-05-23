//
//  DetailsViewController.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import UIKit
import SnapKit
import Combine

final class DetailsViewController: UIViewController {
    
    // MARK: - UI
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .walletBlack
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.poppinsMedium(ofSize: 14.0)
        return nameLabel
    }()
    
    private lazy var backButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .white.withAlphaComponent(0.8)
        configuration.image = UIImage.backArrow
        configuration.contentInsets = .init(
            top: 12.0,
            leading: 12.0,
            bottom: 12.0,
            trailing: 12.0
        )
        
        let backButton = UIButton(configuration: configuration, primaryAction: nil)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return backButton
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = .walletBlack
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.poppinsMedium(ofSize: 28.0)
        return priceLabel
    }()
    
    private lazy var percentLabel: UILabel = {
        let percentLabel = UILabel()
        percentLabel.textColor = .cryptoGray
        percentLabel.textAlignment = .center
        percentLabel.font = UIFont.poppinsMedium(ofSize: 14.0)
        return percentLabel
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.contentMode = .scaleAspectFit
        return arrowImage
    }()
    
    private lazy var percentStackView: UIStackView = {
        let percentStackView = UIStackView()
        percentStackView.axis = .horizontal
        percentStackView.distribution = .equalSpacing
        percentStackView.spacing = 9.0
        percentStackView.alignment = .center
        return percentStackView
    }()
    
    private lazy var timeSliderView = TimeSliderView()
    
    private lazy var whiteBackground: UIView = {
        let whiteBackground = UIView()
        whiteBackground.backgroundColor = .white.withAlphaComponent(0.8)
        whiteBackground.layer.cornerRadius = 40.0
        whiteBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        whiteBackground.clipsToBounds = true
        return whiteBackground
    }()
    
    private lazy var marketStatisticLabel: UILabel = {
        let marketStatisticLabel = UILabel()
        marketStatisticLabel.text = LocalizableStrings.marketStatistic
        marketStatisticLabel.textColor = .walletBlack
        marketStatisticLabel.textAlignment = .left
        marketStatisticLabel.font = UIFont.poppinsMedium(ofSize: 20.0)
        return marketStatisticLabel
    }()
    
    private lazy var capitalizationLabel: UILabel = {
        let capitalizationLabel = UILabel()
        capitalizationLabel.text = LocalizableStrings.marketCapitalization
        capitalizationLabel.textColor = .cryptoGray
        capitalizationLabel.textAlignment = .left
        capitalizationLabel.font = UIFont.poppinsMedium(ofSize: 14.0)
        return capitalizationLabel
    }()
    
    private lazy var suplyLabel: UILabel = {
        let suplyLabel = UILabel()
        suplyLabel.text = LocalizableStrings.circulatingSuply
        suplyLabel.textColor = .cryptoGray
        suplyLabel.textAlignment = .left
        suplyLabel.font = UIFont.poppinsMedium(ofSize: 14.0)
        return suplyLabel
    }()
    
    private lazy var capitalizationValueLabel: UILabel = {
        let capitalizationValueLabel = UILabel()
        capitalizationValueLabel.textColor = .walletBlack
        capitalizationValueLabel.textAlignment = .right
        capitalizationValueLabel.font = UIFont.poppinsSemiBold(ofSize: 14.0)
        return capitalizationValueLabel
    }()
    
    private lazy var suplyValueLabel: UILabel = {
        let suplyValueLabel = UILabel()
        suplyValueLabel.textColor = .walletBlack
        suplyValueLabel.textAlignment = .right
        suplyValueLabel.font = UIFont.poppinsSemiBold(ofSize: 14.0)
        return suplyValueLabel
    }()
    
    // MARK: - Properties
    private let viewModel: DetailsViewModel
    private var bag = Set<AnyCancellable>()
    
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
        binding()
    }
    
    // MARK: - Actions
    @objc private func backTapped() {
        viewModel.onClose?()
    }
    
    // MARK: - Binding
    private func binding() {
        viewModel.currencySubject
            .sink { [weak self] currency in
                self?.setupCurrencyData(with: currency)
            }
            .store(in: &bag)
        
        viewModel.percentChangeSubject
            .sink { [weak self] percent in
                self?.changePercent(percent)
            }
            .store(in: &bag)
        
        timeSliderView.timeIntervalSelected
            .sink { [weak self] timeInterval in
                self?.viewModel.changeTimeInterval(timeInterval)
            }
            .store(in: &bag)
    }
    
    // MARK: - Setup UI
    private func setupView() {
        view.backgroundColor = .walletGray
        
        [nameLabel, backButton, priceLabel, percentStackView, timeSliderView, whiteBackground].forEach {
            view.addSubview($0)
        }
        
        [arrowImage, percentLabel].forEach {
            percentStackView.addArrangedSubview($0)
        }
        
        [marketStatisticLabel, capitalizationLabel, suplyLabel, capitalizationValueLabel, suplyValueLabel].forEach {
            whiteBackground.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5.0)
        }
        
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(48.0)
            make.leading.equalTo(25.0)
            make.centerY.equalTo(nameLabel)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20.0)
        }
        
        percentStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.height.equalTo(5.0)
        }
        
        timeSliderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25.0)
            make.top.equalTo(percentStackView.snp.bottom).offset(20.0)
            make.height.equalTo(56.0)
        }
        
        whiteBackground.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(242.0)
        }
        
        marketStatisticLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(25.0)
        }
        
        capitalizationLabel.snp.makeConstraints { make in
            make.leading.equalTo(marketStatisticLabel)
            make.top.equalTo(marketStatisticLabel.snp.bottom).offset(15.0)
        }
        
        suplyLabel.snp.makeConstraints { make in
            make.leading.equalTo(marketStatisticLabel)
            make.top.equalTo(capitalizationLabel.snp.bottom).offset(15.0)
        }
        
        capitalizationValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-25.0)
            make.centerY.equalTo(capitalizationLabel)
        }
        
        suplyValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(capitalizationValueLabel)
            make.centerY.equalTo(suplyLabel)
        }
    }
    
    private func setupCurrencyData(with currency: CryptoCurrency) {
        nameLabel.text = currency.name + " (" + currency.symbol + ")"
        priceLabel.text = currency.marketData.priceUsd?.formattedCurrency()
        percentLabel.text = "\(abs(currency.marketData.percentChangeUsdLast24Hours ?? 0).formatPercent())"
        arrowImage.image = currency.marketData.percentChangeUsdLast24Hours ?? 0 > 0 ? .arrowUp : .arrowDown
        capitalizationValueLabel.text = currency.marketcap.currentMarketcapUsd?.formattedCurrency()
        if let suplyString = currency.supply.circulating?.formatted() {
            suplyValueLabel.text = [suplyString, currency.symbol].joined(separator: " ")
        }
    }
    
    private func changePercent(_ percent: Double) {
        percentLabel.text = "\(abs(percent).formatPercent())"
        arrowImage.image = percent > 0 ? .arrowUp : .arrowDown
    }
}
