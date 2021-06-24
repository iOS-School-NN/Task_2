//
//  roundView.swift
//  task2.epam.ios
//
//  Created by XO on 21.06.2021.
//  Copyright © 2021 XO. All rights reserved.
//


import UIKit

class ThumbView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        constructItem()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        constructItem()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        constructItem()
    }
    
    var hueValue:CGFloat = 0.5
    var onValueChange: ((_ hueValue: CGFloat) -> Void)?
    
    func constructItem() {
        self.layer.cornerRadius = 20
        self.layer.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.layer.shadowRadius = 9
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 8.0, height: 8.0)
        self.backgroundColor = UIColor(hue: hueValue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveSlider(sender:)))
        self.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func moveSlider (sender: UIPanGestureRecognizer) {
        guard let superview = superview, let view = sender.view else { return }
        let translation = view.center.x + sender.translation(in: superview).x
        
        guard translation <= superview.bounds.width, translation >= 0 else {
            sender.setTranslation(CGPoint.zero, in: superview)
            return
        }
        
        view.center = CGPoint(x: translation, y: view.center.y)
        sender.setTranslation(CGPoint.zero, in: superview)
        hueValue = CGFloat(view.center.x / superview.bounds.width)
        self.backgroundColor = UIColor (hue: hueValue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        onValueChange?(CGFloat(hueValue))
    }
}
