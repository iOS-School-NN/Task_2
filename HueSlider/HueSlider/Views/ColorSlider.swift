//
//  ColorSlider.swift
//  HueSlider
//
//  Created by Alexander on 18.06.2021.
//

import UIKit

protocol ColorSliderDelegate: NSObject {
    func colorSlider(_ colorSlider: ColorSlider,  didChangeValue value: CGFloat)
}

final class ColorSlider: UIView {
    
    weak var delegate: ColorSliderDelegate?
    
    var hueValue: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
            setThumbPosition(by: hueValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.height / 2
        
        thunbView.frame = CGRect(x: 0, y: bounds.height / 2 - thunbView.frame.height / 2,
                                 width: bounds.height * 0.8, height: bounds.height * 0.8)
        thunbView.layer.cornerRadius = thunbView.frame.height / 2
    }

    private lazy var thunbView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemRed
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 4
        return view
    }()
    
    private func configure() {
        backgroundColor = .systemYellow
        addSubview(thunbView)
        thunbView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didMovedThumb)))
    }
    
    private func setThumbPosition(by hueValue: CGFloat) {
        let posX: CGFloat
        if hueValue <= 0 {
            posX = thunbView.frame.width / 2
        } else if hueValue * bounds.width >= bounds.width {
            posX = bounds.width - thunbView.frame.width / 2
        } else {
            posX = hueValue * bounds.width
        }
        thunbView.center = CGPoint(x: posX, y: bounds.height / 2)
    }
    
    @objc private func didMovedThumb(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self).x + thunbView.center.x
        guard bounds.minX + thunbView.frame.width / 2...bounds.maxX - thunbView.frame.width / 2 ~= translation else { return }
        thunbView.center = CGPoint(x: translation, y: thunbView.center.y)
        sender.setTranslation(.zero, in: self)
        
        //let roundedValue = round(translation / frame.width * 10) / 10
        delegate?.colorSlider(self, didChangeValue: translation / frame.width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
