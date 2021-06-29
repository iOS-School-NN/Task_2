//
//  MyVC.swift
//  task2.epam.ios
//
//  Created by XO on 23.06.2021.
//  Copyright © 2021 XO. All rights reserved.
//

import UIKit

protocol SliderDelegate: AnyObject {
    func colorSlider(slider: ThumbView, hueValue: CGFloat)
}

class MyRainbowView: UIView {
    
    weak var delegate: SliderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createHUE()
        let thumbView = ThumbView(frame: self.bounds)
        addSubview(thumbView)
        thumbView.onValueChange = { [unowned self] hueValue in self.delegate?.colorSlider(slider: thumbView, hueValue: hueValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createHUE()
        let thumbView = ThumbView(frame: self.bounds)
        addSubview(thumbView)
        thumbView.onValueChange = { [unowned self] hueValue in self.delegate?.colorSlider(slider: thumbView, hueValue: hueValue)
        }
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createHUE()
        let thumbView = ThumbView(frame: self.bounds)
        addSubview(thumbView)
        thumbView.onValueChange = { [unowned self] hueValue in self.delegate?.colorSlider(slider: thumbView, hueValue: hueValue)
        }
    }
    
    
    func createHUE() {
        let gradient = CAGradientLayer()
        let colors = Array(0...359).map {
            UIColor(hue: CGFloat($0)/359.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
        }
        let sliderLocation = Array(0...359).map {
            NSNumber(value: Float($0)/(359.0))
        }
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.locations = sliderLocation
        gradient.startPoint = CGPoint(x: 0.0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0)
        self.layer.addSublayer(gradient)
    }

}
