//
//  GradientView.swift
//  Task_2
//
//  Created by KirRealDev on 23.06.2021.
//

import UIKit

final class GradientView: UIView {

    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 3
        layer.sublayers?.first?.frame = self.bounds
        
    }
    
    func configure() {
        backgroundColor = .none
        gradientLayer.colors = getArrayOfColors()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        layer.addSublayer(gradientLayer)
        
    }
    
    private func getArrayOfColors() -> [CGColor] {
        return Array(0..<360).map {
            UIColor(hue: CGFloat($0) / 360.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
        }
        
    }

}
