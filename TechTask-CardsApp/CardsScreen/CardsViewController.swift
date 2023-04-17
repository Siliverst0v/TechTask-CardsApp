//
//  CardsViewController.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

class CardsViewController: UIViewController {
    
    private var viewModel: CardsViewModelType
    
    private let activityIndicator = LoadingView()
    
    private lazy var cardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(
            top: 0,
            left: CGFloat.mediumOffset,
            bottom: 0,
            right: CGFloat.mediumOffset
        )
        tableView.backgroundColor = Colors.lightGrey
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CompanyCell.self,
            forCellReuseIdentifier: CompanyCell.reuseIdentifier
        )
        tableView.register(
            LoyaltyCell.self,
            forCellReuseIdentifier: LoyaltyCell.reuseIdentifier
        )
        tableView.register(
            ActionsCell.self,
            forCellReuseIdentifier: ActionsCell.reuseIdentifier
        )
        return tableView
    }()
    
    init(viewModel: CardsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        getCards()
        bindWithErrors()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = StringConstants.cardManagment
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.blue,
            NSAttributedString.Key.font: Fonts.large
        ]
        activityIndicator.spinningCircle.center.x = view.center.x
        cardsTableView.tableHeaderView = activityIndicator
    }
    
    private func setupLayout() {
        view.addSubviews([
            cardsTableView
        ])
        
        NSLayoutConstraint.activate([
            cardsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindWithErrors() {
        
        viewModel.onBadRequestError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert(title: StringConstants.error, message: message)
                self?.cardsTableView.tableHeaderView = nil
                self?.cardsTableView.tableFooterView = nil
            }
        }
        
        viewModel.onAuthError = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlert(title: StringConstants.error, message: StringConstants.authError)
                self?.cardsTableView.tableHeaderView = nil
                self?.cardsTableView.tableFooterView = nil
            }
        }
        
        viewModel.onInternalServerError = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlert(title: StringConstants.error, message: StringConstants.serverError)
                self?.cardsTableView.tableHeaderView = nil
                self?.cardsTableView.tableFooterView = nil
            }
        }
    }
    
    private func getCards() {
        viewModel.getCards(offset: nil) { [weak self] in
            self?.cardsTableView.reloadData()
            self?.cardsTableView.tableHeaderView = nil
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        switch indexPath.row {
        case 0:
            let companyCell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.reuseIdentifier, for: indexPath) as? CompanyCell
            companyCell?.configure(with: viewModel, for: indexPath)
            cell = companyCell ?? CompanyCell()
        case 1:
            let loyaltyCell = tableView.dequeueReusableCell(withIdentifier: LoyaltyCell.reuseIdentifier, for: indexPath) as? LoyaltyCell
            loyaltyCell?.configure(with: viewModel, for: indexPath)
            cell = loyaltyCell ?? LoyaltyCell()
        case 2:
            let actionsCell = tableView.dequeueReusableCell(withIdentifier: ActionsCell.reuseIdentifier, for: indexPath) as? ActionsCell
            actionsCell?.configure(with: viewModel, for: indexPath)
            actionsCell?.actionsDelegate = self
            cell = actionsCell ?? ActionsCell()
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == viewModel.cards.count - 1, viewModel.canLoadMore, !viewModel.isLoading {
            activityIndicator.frame.size.height = CGFloat.activityIndicatorHeight
            tableView.tableFooterView = activityIndicator
            viewModel.getCards(offset: viewModel.cards.count) {
                self.cardsTableView.reloadData()
                tableView.tableFooterView = nil
            }
        } else if !viewModel.canLoadMore {
            tableView.tableFooterView = nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 110
        }
        return 70
    }
}

extension CardsViewController: ButtonsActionDelegate {
    func eyeButtonAction(companyId: String) {
        self.showAlert(title: "", message: StringConstants.eyeButtonTaped + " " + companyId)
    }
    
    func trashButtonAction(companyId: String) {
        self.showAlert(title: "", message: StringConstants.trashButtonTapped + " " + companyId)
    }
    
    func moreButtonAction(companyId: String) {
        self.showAlert(title: "", message: StringConstants.moreButtonTapped + " " + companyId)
    }
}

