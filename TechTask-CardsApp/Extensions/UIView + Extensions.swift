//
//  UIView + Extensions.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subViews: [UIView]) {
        subViews.forEach { addSubview($0) }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subViews: [UIView]) {
        subViews.forEach { addArrangedSubview($0) }
    }
}
