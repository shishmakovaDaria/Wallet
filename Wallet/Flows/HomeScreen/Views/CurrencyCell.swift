//
//  CurrencyCell.swift
//  Wallet
//
//  Created by Дарья Шишмакова on 23.05.2025.
//

import UIKit
import SnapKit

final class CurrencyCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - UI
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .tabbarBlack
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.poppinsMedium(ofSize: 18.0)
        return nameLabel
    }()
    
    private lazy var symbolLabel: UILabel = {
        let symbolLabel = UILabel()
        symbolLabel.textColor = .cryptoGray
        symbolLabel.textAlignment = .left
        symbolLabel.font = UIFont.poppinsMedium(ofSize: 14.0)
        return symbolLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = .tabbarBlack
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont.poppinsMedium(ofSize: 18.0)
        return priceLabel
    }()
    
    private lazy var percentLabel: UILabel = {
        let percentLabel = UILabel()
        percentLabel.textColor = .cryptoGray
        percentLabel.textAlignment = .right
        percentLabel.font = UIFont.poppinsMedium(ofSize: 14.0)
        return percentLabel
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.contentMode = .scaleAspectFit
        return arrowImage
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        [icon, nameLabel, symbolLabel, priceLabel, percentLabel, arrowImage].forEach {
            contentView.addSubview($0)
        }
        
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.0)
            make.leading.equalToSuperview()
            make.height.width.equalTo(50.0)
            make.bottom.equalTo(-20.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(icon)
            make.leading.equalTo(icon.snp.trailing).offset(19.0)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(3.0)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(icon)
            make.trailing.equalToSuperview()
        }
        
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(3.0)
            make.trailing.equalToSuperview()
        }
        
        arrowImage.snp.makeConstraints { make in
            make.height.equalTo(5.0)
            make.centerY.equalTo(percentLabel)
            make.trailing.equalTo(percentLabel.snp.leading).offset(-9.0)
        }
    }
    
    // MARK: - Configure
    func configure(_ currency: CryptoCurrency) {
        icon.image = UIImage(named: currency.symbol)
        nameLabel.text = currency.name
        symbolLabel.text = currency.symbol
        priceLabel.text = currency.marketData.priceUsd?.formattedCurrency()
        percentLabel.text = "\(abs(currency.marketData.percentChangeUsdLast24Hours ?? 0).formatPercent())"
        arrowImage.image = currency.marketData.percentChangeUsdLast24Hours ?? 0 > 0 ? .arrowUp : .arrowDown
    }
}
