//
//  CardCell.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

final class LoyaltyCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let loyaltyCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.large
        return label
    }()
    
    private let marksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium
        label.text = StringConstants.marks
        return label
    }()
    
    private let cashBackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.small
        label.text = StringConstants.cashBack
        return label
    }()
    
    private let loyaltyNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium
        return label
    }()
    
    private let cashBackNumberStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = CGFloat.smallOffset
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.small
        label.text = StringConstants.level
        return label
    }()
    
    private let loyaltyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium
        return label
    }()
    
    private let levelStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = CGFloat.smallOffset
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loyaltyCountLabel.text = nil
        loyaltyCountLabel.text = nil
        loyaltyNameLabel.text = nil
    }
    private func setupView() {
        backgroundColor = Colors.white
    }
    
    private func setupLayout() {
        
        cashBackNumberStack.addArrangedSubviews([
            cashBackLabel,
            loyaltyNumberLabel
        ])
        
        levelStack.addArrangedSubviews([
            levelLabel,
            loyaltyNameLabel
        ])
        
        addSubviews([
            loyaltyCountLabel,
            marksLabel,
            cashBackNumberStack,
            levelStack
        ])
        
        NSLayoutConstraint.activate([
            
            loyaltyCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.mediumOffset),
            loyaltyCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.mediumOffset),
            
            marksLabel.leadingAnchor.constraint(equalTo: loyaltyCountLabel.trailingAnchor, constant: CGFloat.smallOffset),
            marksLabel.bottomAnchor.constraint(equalTo: loyaltyCountLabel.bottomAnchor),
            
            cashBackNumberStack.topAnchor.constraint(equalTo: loyaltyCountLabel.bottomAnchor, constant: CGFloat.mediumOffset),
            cashBackNumberStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.mediumOffset),
            cashBackNumberStack.widthAnchor.constraint(equalToConstant: CGFloat.cashBackStackWidth),
            
            levelStack.topAnchor.constraint(equalTo: loyaltyCountLabel.bottomAnchor, constant: CGFloat.mediumOffset),
            levelStack.leadingAnchor.constraint(equalTo: cashBackNumberStack.trailingAnchor, constant: CGFloat.largeOffset),
            levelStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.mediumOffset)
            
        ])
    }
}

extension LoyaltyCell {
    func configure(with viewModel: CardsViewModelType, for indexPath: IndexPath) {
        let cellInfo = viewModel.getCellInfo(for: indexPath)
        let cardBackgroundColor = cellInfo.mobileAppDashboard.cardBackgroundColor
        backgroundColor = UIColor(hex: cardBackgroundColor)
        
        let highlightTextColor = cellInfo.mobileAppDashboard.highlightTextColor
        loyaltyCountLabel.textColor = UIColor(hex: highlightTextColor)
        loyaltyCountLabel.text = "\(cellInfo.customerMarkParameters.mark)"
        
        let textColor = cellInfo.mobileAppDashboard.textColor
        marksLabel.textColor = UIColor(hex: textColor)
        levelLabel.textColor = UIColor(hex: textColor)
        cashBackLabel.textColor = UIColor(hex: textColor)
        
        loyaltyNumberLabel.text = "\(cellInfo.customerMarkParameters.loyaltyLevel.number) %"
        loyaltyNameLabel.text = "\(cellInfo.customerMarkParameters.loyaltyLevel.name)"
    }
}
