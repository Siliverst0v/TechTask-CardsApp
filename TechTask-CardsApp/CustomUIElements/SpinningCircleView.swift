//
//  SpinningCircleView.swift
//  TechTask-CardsApp
//
//  Created by Анатолий Силиверстов on 15.04.2023.
//

import UIKit

final class SpinningCircleView: UIView {
    
    let spinningCircle = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
        
        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor = Colors.black.cgColor
        spinningCircle.lineWidth = 5
        spinningCircle.strokeEnd = 0.25
        spinningCircle.lineCap = .round
        
        layer.addSublayer(spinningCircle)
    }
    
    func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { completed in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { completed in
                self.animate()
            }
        }
    }
    
}
