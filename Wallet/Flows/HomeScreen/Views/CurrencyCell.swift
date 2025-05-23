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
        self.backgroundColor = .red
        self.selectionStyle = .none
    }
    
    // MARK: - Configure
    func configure(_ currency: CryptoCurrency) {
       
    }
}
