//
//  ThumbView.swift
//  Hue Slider
//
//  Created by Step ToVictory on 01.07.2021.
//

import UIKit

protocol ThumbViewDelegate {
    func thumbView(_ colorSlider: ThumbView, didChangeValue value: CGFloat)
}

class ThumbView: UIView {
    
    var hue: CGFloat = 0 {
            didSet {
                setSlider(hueVal: hue)
            }
        }
    
    lazy var sliderView: UIView = {
        let sliderView = UIView(frame: .zero)
        
        sliderView.layer.cornerRadius = 25
        sliderView.layer.shadowColor = UIColor.gray.cgColor
        sliderView.layer.shadowOpacity = 1
        sliderView.layer.shadowRadius = 6
        sliderView.layer.borderColor = UIColor.black.cgColor
        return sliderView
    }()
    
    let gradientLayer: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.startPoint = CGPoint(x: 0.0, y: 0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0)
            gradient.colors = Array(0...359).map {
                UIColor(hue: CGFloat($0) / 359.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
            }
            return gradient
        }()
    
    var delegate: ThumbViewDelegate?
    
    private func setSlider(hueVal: CGFloat) {
            let x: CGFloat
            if hueVal <= 0 {
                x = sliderView.frame.width / 2
            } else if hueVal * bounds.width >= bounds.width {
                x = bounds.width - sliderView.frame.width / 2
            } else {
                x = hueVal * bounds.width
            }
        sliderView.center = CGPoint(x: x, y: bounds.height / 2)
        
        sliderView.backgroundColor = UIColor(hue: hueVal, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        
    @objc func dragSlider(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self).x + sliderView.center.x

                guard translation < bounds.width || translation > 0 else {
                    sender.setTranslation(CGPoint.zero, in: superview)
                    return
                }

                hue = translation / bounds.width
                delegate?.thumbView(self, didChangeValue: hue)
                sender.setTranslation(CGPoint.zero, in: superview)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        sliderView.frame.size = CGSize(width: bounds.height * 0.8, height: bounds.height * 0.8)
        sliderView.layer.cornerRadius = sliderView.frame.height / 2

                setSlider(hueVal: hue)
                
                gradientLayer.frame = CGRect(origin: .zero, size: bounds.size)
                gradientLayer.cornerRadius = frame.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        addSubview(sliderView)
        sliderView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragSlider)))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(gradientLayer)
        addSubview(sliderView)
        sliderView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragSlider)))
       }


}
