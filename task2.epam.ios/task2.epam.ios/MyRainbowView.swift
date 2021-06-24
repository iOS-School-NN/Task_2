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
        let mySlider = ThumbView(frame: self.bounds)
        addSubview(mySlider)
        mySlider.onValueChange = { [unowned self] hueValue in self.delegate?.colorSlider(slider: mySlider, hueValue: hueValue)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createHUE()
        let mySlider = ThumbView(frame: self.bounds)
        addSubview(mySlider)
        mySlider.onValueChange = { [unowned self] hueValue in self.delegate?.colorSlider(slider: mySlider, hueValue: hueValue)
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createHUE()
        let mySlider = ThumbView(frame: self.bounds)
        addSubview(mySlider)
        mySlider.onValueChange = { [unowned self] hueValue in self.delegate?.colorSlider(slider: mySlider, hueValue: hueValue)
        }
    }
        
    
    let colors = Array(0...359).map {
        UIColor(hue: CGFloat($0)/359.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
    }
    let sliderLocation = Array(0...359).map {
        NSNumber(value: Float($0)/(359.0))
    }
    
    func createHUE() {
        let gradient = CAGradientLayer()
               gradient.frame = self.bounds
               gradient.colors = colors
               gradient.locations = sliderLocation
               gradient.startPoint = CGPoint(x: 0.0, y: 0)
               gradient.endPoint = CGPoint(x: 1.0, y: 0)
               self.layer.addSublayer(gradient)
    }

}
