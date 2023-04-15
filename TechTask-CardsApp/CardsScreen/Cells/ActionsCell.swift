//
//  ActionsCell.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

protocol ButtonsActionDelegate: AnyObject {
    func eyeButtonAction(companyId: String)
    func trashButtonAction(companyId: String)
    func moreButtonAction(companyId: String)
}

final class ActionsCell: UITableViewCell {
    static var reuseIdentifier: String { "\(Self.self)" }
    weak var actionsDelegate: ButtonsActionDelegate?
    private var companyId = ""
    
    lazy var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.eye, for: .normal)
        button.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var trashButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.trash, for: .normal)
        button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(StringConstants.moreButtonTitle, for: .normal)
        button.titleLabel?.font = Fonts.medium
        button.layer.cornerRadius = CGFloat.moreButtonCornerRadius
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.white
    }
    
    private func setupLayout() {
        
        contentView.addSubviews([
            eyeButton,
            trashButton,
            moreButton
        ])
        
        NSLayoutConstraint.activate([
            eyeButton.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.mediumOffset),
            eyeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.doubleMediumOffset),
            eyeButton.heightAnchor.constraint(equalToConstant: CGFloat.smallButtonSize),
            eyeButton.widthAnchor.constraint(equalToConstant: CGFloat.smallButtonSize),
            
            trashButton.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.mediumOffset),
            trashButton.leadingAnchor.constraint(equalTo: eyeButton.trailingAnchor, constant: CGFloat.largeOffset),
            trashButton.heightAnchor.constraint(equalToConstant: CGFloat.smallButtonSize),
            trashButton.widthAnchor.constraint(equalToConstant: CGFloat.smallButtonSize),
            
            moreButton.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.smallOffset),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat.mediumOffset),
            moreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CGFloat.mediumOffset),
            moreButton.widthAnchor.constraint(equalToConstant: CGFloat.moreButtonWidth),
        ])
    }
    
    @objc private func eyeButtonTapped() {
        actionsDelegate?.eyeButtonAction(companyId: companyId)
    }
    
    @objc private func trashButtonTapped() {
        actionsDelegate?.trashButtonAction(companyId: companyId)
    }
    
    @objc private func moreButtonTapped() {
        actionsDelegate?.moreButtonAction(companyId: companyId)
    }
}

extension ActionsCell {
    func configure(with viewModel: CardsViewModelType, for indexPath: IndexPath) {
        let cellInfo = viewModel.getCellInfo(for: indexPath)
        self.companyId = cellInfo.company.companyId
        
        let cardBackgroundColor = cellInfo.mobileAppDashboard.cardBackgroundColor
        backgroundColor = UIColor(hex: cardBackgroundColor)
        
        let mainColor = cellInfo.mobileAppDashboard.mainColor
        eyeButton.tintColor = UIColor(hex: mainColor)
        moreButton.setTitleColor(UIColor(hex: mainColor), for: .normal)
        
        let accentColor = cellInfo.mobileAppDashboard.accentColor
        trashButton.tintColor = UIColor(hex: accentColor)
        
        let backgroundColor = cellInfo.mobileAppDashboard.backgroundColor
        moreButton.backgroundColor = UIColor(hex: backgroundColor)
    }
}
