//
//  ChosenColorView.swift
//  Task_2
//
//  Created by KirRealDev on 23.06.2021.
//

import UIKit

final class ChosenColorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        
    }
    
    func configure(colorValue: CGFloat) {
        backgroundColor = UIColor(hue: colorValue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
}
