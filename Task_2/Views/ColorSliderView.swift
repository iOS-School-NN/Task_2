//
//  ColorSliderView.swift
//  Task_2
//
//  Created by KirRealDev on 23.06.2021.
//

import UIKit

protocol ColorSliderDelegate: AnyObject {
    func colorSlider(_ colorSlider: ColorSliderView,  didChangeValue value: CGFloat)

}

final class ColorSliderView: UIView {
    
    private enum Size: CGFloat {
        case thumbValue = 25.0 // height and width for ThumbView
        case chosenColorValue = 20.0 // height and width for ChosenColorView
    }
    
    private var hueValue: CGFloat = 0.0

    private let gradientView = GradientView()
    private let thumbView = ThumbView()
    private let chosenColorView = ChosenColorView()
    
    weak var colorSliderDelegate: ColorSliderDelegate? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
 
        configureGradientLayer()
        configureThumbView()
        configureChosenColorView()
    
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        changeThumbPosition()

    }
    
    func set(hueValue: CGFloat) {
        self.hueValue = hueValue
        
    }
    
    func changeThumbPosition() {
        thumbView.center = CGPoint(x: bounds.width * hueValue, y: thumbView.center.y)
        setChosenColorView(value: self.hueValue)
        
    }
    
    private func configureGradientLayer() {
        addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            gradientView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
    }
    
    private func configureThumbView() {
        addSubview(thumbView)
        thumbView.translatesAutoresizingMaskIntoConstraints = false
        thumbView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            thumbView.heightAnchor.constraint(equalToConstant: Size.thumbValue.rawValue),
            thumbView.widthAnchor.constraint(equalToConstant: Size.thumbValue.rawValue),
            thumbView.centerXAnchor.constraint(equalTo: centerXAnchor),
            thumbView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addColorSliderGestureRecognizer()
    
    }
    
    private func configureChosenColorView() {
        thumbView.addSubview(chosenColorView)
        chosenColorView.translatesAutoresizingMaskIntoConstraints = false
        chosenColorView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            chosenColorView.heightAnchor.constraint(equalToConstant: Size.chosenColorValue.rawValue),
            chosenColorView.widthAnchor.constraint(equalToConstant: Size.chosenColorValue.rawValue),
            chosenColorView.centerXAnchor.constraint(equalTo: thumbView.centerXAnchor),
            chosenColorView.centerYAnchor.constraint(equalTo: thumbView.centerYAnchor)
        ])
    }
    
    func setChosenColorView(value: CGFloat) {
        chosenColorView.configure(colorValue: value)
        
    }
    
    private func addColorSliderGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(colorSliderMoved(sender:)))
        thumbView.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc func colorSliderMoved(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self).x + thumbView.center.x
        
        guard translation >= bounds.minX + thumbView.bounds.width / 2, translation <= bounds.maxX - thumbView.bounds.width / 2 else { return }
        
        thumbView.center = CGPoint(x: translation, y: thumbView.center.y)
        sender.setTranslation(CGPoint.zero, in: self)
        
        hueValue = translation / frame.width
        setChosenColorView(value: hueValue)
        
        colorSliderDelegate?.colorSlider(self, didChangeValue: hueValue)
        
    }

}
