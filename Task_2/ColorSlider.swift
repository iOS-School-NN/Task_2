//
//  ColorSlider.swift
//  Task_2
//
//  Created by R S on 29.06.2021.
//

import UIKit

protocol ColorSliderDelegate {
    func colorSlider(_ colorSlider: ColorSlider, didChangeValue value: CGFloat)
}

class ColorSlider: UIView {
    
    lazy var sliderView: UIView = {
        let sliderView = UIView(frame: .zero)
        
        sliderView.layer.cornerRadius = 25
        sliderView.layer.shadowColor = UIColor.black.cgColor
        sliderView.layer.shadowOpacity = 1
        sliderView.layer.shadowOffset = .zero
        sliderView.layer.shadowRadius = 5
        return sliderView
    }()
    
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
        }
        
        private func setSliderColor(hueVal: CGFloat) {
            sliderView.backgroundColor = UIColor(hue: hueVal, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
    
    var hue: CGFloat = 0 {
            didSet {
                setSlider(hueVal: hue)
                setSliderColor(hueVal: hue)
            }
        }
    
    var delegate: ColorSliderDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        sliderView.frame.size = CGSize(width: bounds.height * 0.7, height: bounds.height * 0.7)
        sliderView.layer.cornerRadius = sliderView.frame.height / 2
        sliderView.layer.shadowPath = CGPath(roundedRect: sliderView.bounds,
                                                    cornerWidth: sliderView.frame.height / 2,
                                                    cornerHeight: sliderView.frame.height / 2,
                                                    transform: nil)
                setSlider(hueVal: hue)
                setSliderColor(hueVal: hue)
                
                gradientLayer.frame = CGRect(origin: .zero, size: bounds.size)
                gradientLayer.cornerRadius = frame.height / 2
    }
    
    let gradientLayer: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.startPoint = CGPoint(x: 0.0, y: 0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0)
            gradient.colors = Array(0...359).map {
                UIColor(hue: CGFloat($0) / 359.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
            }
            return gradient
        }()

    @objc func dragSlider(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self).x + sliderView.center.x
        guard bounds.minX + sliderView.frame.width / 2...bounds.maxX - sliderView.frame.width / 2 ~= translation else { return }
            sliderView.center = CGPoint(x: translation, y: sliderView.center.y)
            recognizer.setTranslation(.zero, in: superview)
            hue = translation / bounds.width
            setSliderColor(hueVal: hue)
            delegate?.colorSlider(self, didChangeValue: hue)
    }
    
    func setUI() {
            layer.addSublayer(gradientLayer)
            addSubview(sliderView)
            sliderView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragSlider)))
        }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
