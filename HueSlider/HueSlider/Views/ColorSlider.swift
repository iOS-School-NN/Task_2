//
//  ColorSlider.swift
//  HueSlider
//
//  Created by Alexander on 18.06.2021.
//

import UIKit

protocol ColorSliderDelegate: AnyObject {
    func colorSlider(_ colorSlider: ColorSlider, didChangeValue value: CGFloat)
}

final class ColorSlider: UIView {
    
    weak var delegate: ColorSliderDelegate?
    
    var hueValue: CGFloat = 0 {
        didSet {
            setThumbPosition()
            setThumbColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2

        thumbView.frame.size = CGSize(width: bounds.height * 0.8, height: bounds.height * 0.8)
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        thumbView.layer.shadowPath = CGPath(roundedRect: thumbView.bounds,
                                            cornerWidth: thumbView.frame.height / 2,
                                            cornerHeight: thumbView.frame.height / 2,
                                            transform: nil)
        setThumbPosition()
        setThumbColor()
        
        gradientLayer.frame = CGRect(origin: .zero, size: bounds.size)
        gradientLayer.cornerRadius = frame.height / 2
    }
    
    private var validHueValue: CGFloat {
        switch hueValue {
        case ..<0: return 0
        case 1...: return 1
        default: return hueValue
        }
    }
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = Array(0...360).map {
            UIColor(hue: CGFloat($0) / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
        }
        return gradient
    }()

    private lazy var thumbView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 4
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 2, height: 0)
        return view
    }()
    
    private func configure() {
        layer.addSublayer(gradientLayer)
        addSubview(thumbView)
        thumbView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didMovedThumb)))
    }
    
    private func setThumbPosition() {
        let posX: CGFloat
        switch validHueValue {
        case 0.0: posX = thumbView.frame.width / 2
        case 1.0: posX = bounds.width - thumbView.frame.width / 2
        default: posX = validHueValue * bounds.width
        }
        thumbView.center = CGPoint(x: posX, y: bounds.height / 2)
    }
    
    private func setThumbColor() {
        thumbView.backgroundColor = UIColor(hue: validHueValue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    
    @objc private func didMovedThumb(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self).x + thumbView.center.x
        guard bounds.minX + thumbView.frame.width / 2...bounds.maxX - thumbView.frame.width / 2 ~= translation else { return }
        hueValue = translation / frame.width
        sender.setTranslation(.zero, in: self)
        
        delegate?.colorSlider(self, didChangeValue: hueValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
