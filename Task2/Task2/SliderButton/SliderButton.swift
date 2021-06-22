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
    
    var hueVal: CGFloat = 0.2
    
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
        center = CGPoint(x: hueVal * superview.bounds.width, y: center.y)
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
        let translation = sender.translation(in: superview).x + view.center.x
        
        guard translation <= superview.bounds.width, translation >= 0 else {
            sender.setTranslation(CGPoint.zero, in: superview)
            return
        }
        
        view.center = CGPoint(x: translation, y: view.center.y)
        sender.setTranslation(CGPoint.zero, in: superview)
        hueVal = view.center.x / superview.bounds.width
        
        guard let inImageView = inImageView else { return }
        inImageView.backgroundColor = UIColor(hue: hueVal, saturation: 1, brightness: 1, alpha: 1)
        
        delegate?.colorSlider(slider: self, hueVal: hueVal)
    }
}
