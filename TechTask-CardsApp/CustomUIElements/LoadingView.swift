//
//  LoadingView.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

final class LoadingView: UIView {
    
    let spinningCircle: SpinningCircleView = {
        let view = SpinningCircleView()
        view.animate()
        return view
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = StringConstants.loading
        label.font = Fonts.medium
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupLayout() {
        addSubviews([
            spinningCircle,
            loadingLabel
        ])
        
        NSLayoutConstraint.activate([
            
            loadingLabel.topAnchor.constraint(equalTo: spinningCircle.bottomAnchor, constant: CGFloat.smallOffset),
            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
}
