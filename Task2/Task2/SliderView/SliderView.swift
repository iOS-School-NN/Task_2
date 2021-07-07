//
//  SliderButton.swift
//  Task2
//
//  Created by Grifus on 17.06.2021.
//

import UIKit

protocol SliderDelegate: AnyObject {
    func colorSlider(slider: SliderView, didChange hueValue: CGFloat)
}

class SliderView: UIView {
    
    weak var delegate: SliderDelegate?
    
    var hueValue: CGFloat = 0.2
        
    let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 60))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderRecognizer()
        createGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setStartPosition()
        configureThumbView()
    }
    
    func setStartPosition() {
        if hueValue < 0 { hueValue = 0 }
        if hueValue > 1 { hueValue = 1 }
        
        center = CGPoint(x: (hueValue * gradientView.bounds.width) + gradientView.frame.minX, y: center.y)
    }
    
    private func configureThumbView() {
        backgroundColor = UIColor(hue: hueValue, saturation: 1, brightness: 1, alpha: 1)
        
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
        guard let view = sender.view else { return }
        let translation = sender.translation(in: gradientView).x + view.center.x
        guard translation <= gradientView.frame.maxX, translation >= gradientView.frame.minX else {
            sender.setTranslation(CGPoint.zero, in: gradientView)
            return
        }
        
        view.center = CGPoint(x: translation, y: view.center.y)
        sender.setTranslation(CGPoint.zero, in: gradientView)
        hueValue = (view.center.x - gradientView.frame.minX) / gradientView.bounds.width
        
        backgroundColor = UIColor(hue: hueValue, saturation: 1, brightness: 1, alpha: 1)
        
        delegate?.colorSlider(slider: self, didChange: hueValue)
    }
    
    private func createGradient() {
        guard let superview = superview else { return }
        gradientView.center = superview.center
        
        let gradientLayer = CAGradientLayer()
        var colors = [CGColor]()
        gradientLayer.frame = gradientView.bounds
        for oneColorValue in 0...360 {
            colors.append(UIColor(hue: CGFloat(Double(oneColorValue) * 1 / 360), saturation: 1, brightness: 1, alpha: 1).cgColor)
        }
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.cornerRadius = gradientLayer.bounds.width * 0.05
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
        superview.addSubview(gradientView)
        superview.sendSubviewToBack(gradientView)
    }
}
