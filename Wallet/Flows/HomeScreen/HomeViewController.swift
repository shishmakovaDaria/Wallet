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
    private lazy var homeLabel: UILabel = {
        let homeLabel = UILabel()
        homeLabel.text = LocalizableStrings.home
        homeLabel.textColor = .white
        homeLabel.textAlignment = .left
        homeLabel.font = UIFont.poppinsSemiBold(ofSize: 32.0)
        return homeLabel
    }()
    
    private lazy var menuButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .white.withAlphaComponent(0.8)
        configuration.image = UIImage.dots
        configuration.imagePlacement = .all
        configuration.contentInsets = .init(
            top: 12.0,
            leading: 12.0,
            bottom: 12.0,
            trailing: 12.0
        )
        
        let menuButton = UIButton(configuration: configuration, primaryAction: nil)
        menuButton.isUserInteractionEnabled = true
        let menu = createMenu()
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
        return menuButton
    }()
    
    private lazy var affiliateLabel: UILabel = {
        let affiliateLabel = UILabel()
        affiliateLabel.text = LocalizableStrings.affiliateProgram
        affiliateLabel.textColor = .white
        affiliateLabel.textAlignment = .left
        affiliateLabel.font = UIFont.poppinsMedium(ofSize: 20.0)
        return affiliateLabel
    }()
    
    private lazy var learnButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .tabbarBlack
        var container = AttributeContainer()
        container.font = UIFont.poppinsSemiBold(ofSize: 14.0)
        configuration.attributedTitle = AttributedString(LocalizableStrings.learnMore, attributes: container)
        
        let learnButton = UIButton(configuration: configuration, primaryAction: nil)
        return learnButton
    }()
    
    private lazy var illustration = UIImageView(image: .illustration)
    
    private lazy var grayBackground: UIView = {
        let grayBackground = UIView()
        grayBackground.backgroundColor = .homeGray
        grayBackground.layer.cornerRadius = 40.0
        grayBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        grayBackground.clipsToBounds = true
        return grayBackground
    }()
    
    private lazy var trendingLabel: UILabel = {
        let trendingLabel = UILabel()
        trendingLabel.text = LocalizableStrings.trending
        trendingLabel.textColor = .walletBlack
        trendingLabel.textAlignment = .left
        trendingLabel.font = UIFont.poppinsMedium(ofSize: 20.0)
        return trendingLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = true
        tableView.register(CurrencyCell.self)
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - Properties
    private let viewModel: HomeViewModel
    private var bag = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Int, CryptoCurrency>! = nil
    
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
        configureDataSource()
        binding()
        viewModel.fetchCurrencies()
    }
    
    // MARK: - Binding
    private func binding() {
        viewModel.currenciesSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currencies in
                self?.updateTableView(with: currencies)
            }
            .store(in: &bag)
        
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
            .store(in: &bag)
        
        viewModel.errorSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showNetworkAlert(title: LocalizableStrings.error, with: errorMessage)
            }
            .store(in: &bag)
    }
    
    // MARK: - Setup UI
    private func setupView() {
        view.backgroundColor = .walletPink
        
        [homeLabel, menuButton, affiliateLabel, learnButton, illustration, grayBackground].forEach {
            view.addSubview($0)
        }
        
        [trendingLabel, tableView, activityIndicator].forEach {
            grayBackground.addSubview($0)
        }
        
        homeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5.0)
            make.leading.equalTo(25.0)
        }
        
        menuButton.snp.makeConstraints { make in
            make.centerY.equalTo(homeLabel)
            make.trailing.equalTo(-25.0)
            make.height.width.equalTo(48.0)
        }
        
        affiliateLabel.snp.makeConstraints { make in
            make.leading.equalTo(homeLabel)
            make.top.equalTo(homeLabel.snp.bottom).offset(46.0)
        }
        
        learnButton.snp.makeConstraints { make in
            make.leading.equalTo(homeLabel)
            make.top.equalTo(affiliateLabel.snp.bottom).offset(12.0)
            make.height.equalTo(35.0)
            make.width.equalTo(127.0)
        }
        
        illustration.snp.makeConstraints { make in
            make.top.equalTo(menuButton.snp.bottom).offset(21.0)
            make.trailing.equalToSuperview()
        }
        
        grayBackground.snp.makeConstraints { make in
            make.top.equalTo(learnButton.snp.bottom).offset(55.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        trendingLabel.snp.makeConstraints { make in
            make.leading.equalTo(homeLabel)
            make.top.equalTo(24.0)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25.0)
            make.top.equalTo(trendingLabel.snp.bottom).offset(16.0)
            make.bottom.equalTo(-90.0)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func createMenu() -> UIMenu {
        let menu = UIMenu(
            title: "",
            options: .displayInline,
            children: [
                UIAction(
                    title: LocalizableStrings.refresh,
                    image: UIImage(resource: .rocket)
                ) { [weak self] _ in
                    self?.viewModel.fetchCurrencies()
                },
                UIAction(
                    title: LocalizableStrings.logout,
                    image: UIImage(resource: .trash)
                ) { [weak self] _ in
                    self?.viewModel.logoutUser()
                }
            ]
        )
        return menu
    }
}

// MARK: - TableViewDiffableDataSource
private extension HomeViewController {
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, CryptoCurrency>(
            tableView: tableView) { tableView, indexPath, currency in
                let cell: CurrencyCell = tableView.dequeueReusableCell()
                cell.configure(currency)
                return cell
        }
        tableView.dataSource = dataSource
    }
    
    func updateTableView(with currencies: [CryptoCurrency]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CryptoCurrency>()
        snapshot.appendSections([0])
        snapshot.appendItems(currencies)
        
        let shouldAnimate = dataSource.snapshot().itemIdentifiers.isEmpty == false
        dataSource.apply(snapshot, animatingDifferences: shouldAnimate)
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //todo
    }
}
