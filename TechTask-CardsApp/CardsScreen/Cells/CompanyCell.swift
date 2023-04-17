//
//  CompanyCell.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

final class CompanyCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.large
        return label
    }()
    
    private lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
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
        logoView.image = nil
        companyNameLabel.text = nil
    }
    private func setupView() {
        backgroundColor = Colors.white
    }
    
    private func setupLayout() {
        addSubviews([
            companyNameLabel,
            logoView
        ])
        
        NSLayoutConstraint.activate([
            companyNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.mediumOffset),
            companyNameLabel.trailingAnchor.constraint(equalTo: logoView.leadingAnchor),
            
            logoView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.mediumOffset),
            logoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CGFloat.smallOffset),
            logoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.mediumOffset),
            logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor),
        ])
    }
}

extension CompanyCell {
    func configure(with viewModel: CardsViewModelType, for indexPath: IndexPath) {
        let cellInfo = viewModel.getCellInfo(for: indexPath)
        
        let cardBackgroundColor = cellInfo.mobileAppDashboard.cardBackgroundColor
        backgroundColor = UIColor(hex: cardBackgroundColor)
        
        let highlightTextColor = cellInfo.mobileAppDashboard.highlightTextColor
        companyNameLabel.text = cellInfo.mobileAppDashboard.companyName
        companyNameLabel.textColor = UIColor(hex: highlightTextColor)
        
        viewModel.getImage(from: cellInfo.mobileAppDashboard.logo) { image in
            self.logoView.image = image
            self.logoView.layer.cornerRadius = self.logoView.frame.size.height / 2
        }
    }
    
}
