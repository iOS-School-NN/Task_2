//
//  ThumbView.swift
//  Task_2
//
//  Created by KirRealDev on 23.06.2021.
//

import UIKit

final class ThumbView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        
    }
    
    private func configure() {
        backgroundColor = UIColor.white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 6
        layer.shadowOpacity = 2
        
    }

}
