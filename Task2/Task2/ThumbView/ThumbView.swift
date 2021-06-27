//
//  SliderButton.swift
//  Task2
//
//  Created by Grifus on 17.06.2021.
//

import UIKit

protocol SliderDelegate {
    func colorSlider(slider: ThumbView, hueVal: CGFloat)
}

class ThumbView: UIView {
    var delegate: SliderDelegate?
    
    var hueVal: CGFloat = 0.2
        
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderRecognizer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setStartPosition()
        configureThumbView()
    }
    
    func setStartPosition() {
        guard let superview = superview else { return }
        let superviewGradient = superview.subviews[0]
        
        if hueVal < 0 { hueVal = 0 }
        if hueVal > 1 { hueVal = 1 }
        
        center = CGPoint(x: (hueVal * superviewGradient.bounds.width) + superviewGradient.frame.minX, y: center.y)
    }
    
    private func configureThumbView() {
        backgroundColor = UIColor(hue: hueVal, saturation: 1, brightness: 1, alpha: 1)
        
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 7
        layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    private func sliderRecognizer() {
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(moveSlider(sender:)))
        addGestureRecognizer(panGR)
    }
    
    @objc private func moveSlider(sender: UIPanGestureRecognizer) {
        guard let superview = superview, let view = sender.view else { return }
        let superviewGradient = superview.subviews[0]
        let translation = sender.translation(in: superviewGradient).x + view.center.x
        guard translation <= superviewGradient.frame.maxX, translation >= superviewGradient.frame.minX else {
            sender.setTranslation(CGPoint.zero, in: superviewGradient)
            return
        }
        
        view.center = CGPoint(x: translation, y: view.center.y)
        sender.setTranslation(CGPoint.zero, in: superviewGradient)
        hueVal = (view.center.x - superviewGradient.frame.minX) / superviewGradient.bounds.width
        
        backgroundColor = UIColor(hue: hueVal, saturation: 1, brightness: 1, alpha: 1)
        
        delegate?.colorSlider(slider: self, hueVal: hueVal)
    }
}
