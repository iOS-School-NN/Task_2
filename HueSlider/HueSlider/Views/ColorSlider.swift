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
            setThumbPosition(by: hueValue)
            setThumbColor(by: hueValue)
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
        setThumbPosition(by: hueValue)
        setThumbColor(by: hueValue)
        
        gradientLayer.frame = CGRect(origin: .zero, size: bounds.size)
        gradientLayer.cornerRadius = frame.height / 2
    }
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.colors = stride(from: 0, to: 360, by: 30).map {
            UIColor(hue: $0 / 360, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
        }
        return gradient
    }()

    private lazy var thumbView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemRed
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 4
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 2, height: 0)
        return view
    }()
    
    private func configure() {
        backgroundColor = .systemYellow
        layer.addSublayer(gradientLayer)
        addSubview(thumbView)
        thumbView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didMovedThumb)))
    }
    
    private func setThumbPosition(by hueValue: CGFloat) {
        let posX: CGFloat
        if hueValue <= 0 {
            posX = thumbView.frame.width / 2
        } else if hueValue * bounds.width >= bounds.width {
            posX = bounds.width - thumbView.frame.width / 2
        } else {
            posX = hueValue * bounds.width
        }
        thumbView.center = CGPoint(x: posX, y: bounds.height / 2)
    }
    
    private func setThumbColor(by hueValue: CGFloat) {
        thumbView.backgroundColor = UIColor(hue: hueValue - 0.05, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    
    @objc private func didMovedThumb(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self).x + thumbView.center.x
        guard bounds.minX + thumbView.frame.width / 2...bounds.maxX - thumbView.frame.width / 2 ~= translation else { return }
        thumbView.center = CGPoint(x: translation, y: thumbView.center.y)
        sender.setTranslation(.zero, in: self)
        
        hueValue = translation / frame.width
        setThumbColor(by: hueValue)
        
        delegate?.colorSlider(self, didChangeValue: hueValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
