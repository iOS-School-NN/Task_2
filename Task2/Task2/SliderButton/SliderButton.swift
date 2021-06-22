//
//  SliderButton.swift
//  Task2
//
//  Created by Grifus on 17.06.2021.
//

import UIKit

protocol SliderDelegate {
    func colorSlider(slider: SliderButton, hueVal: CGFloat)
}

class SliderButton: UIView {
    var delegate: SliderDelegate?
    weak var inImageView: UIImageView?
    
    var hueVal: CGFloat = 0.3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buildSliderButton()
        sliderRecognizer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        inImageView?.layer.cornerRadius = (inImageView?.bounds.height)! / 2
        start()
    }
    
    func start() {
        guard let superview = superview else { return }
        let superviewGradient = superview.subviews[0]
        center = CGPoint(x: (hueVal * superviewGradient.bounds.width) + superviewGradient.frame.minX, y: center.y)
    }
    
    private func buildSliderButton() {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(hue: hueVal, saturation: 1, brightness: 1, alpha: 1)
        imageView.contentMode = .scaleToFill

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        inImageView = imageView
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
        
        guard let inImageView = inImageView else { return }
        inImageView.backgroundColor = UIColor(hue: hueVal, saturation: 1, brightness: 1, alpha: 1)
        
        delegate?.colorSlider(slider: self, hueVal: hueVal)
    }
}
