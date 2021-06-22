//
//  GradienView.swift
//  Task2
//
//  Created by Mary Matichina on 20.06.2021.
//

import UIKit

@IBDesignable class ColorSlider: UIView {
    
    // MARK: - Properties
    
    @IBInspectable private var startColor: UIColor =  UIColor.red {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable private var medium: UIColor = UIColor.purple {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable private var endColor: UIColor = UIColor.yellow {
        didSet {
            updateColors()
        }
    }
   
    @IBInspectable private var startLocation: Double = 0.0 {
        didSet {
            updateLocations()
        }
    }
    
    @IBInspectable private var mediumLocation: Double = 0.50 {
        didSet {
        updateLocations()
        }
    }
    
    @IBInspectable private var endLocation: Double = 1.0 {
        didSet {
            updateLocations()
        }
    }
    
    private var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }
    
    override public class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
    
    // MARK: - Configure
    
    private func updatePoints() {
        gradientLayer.startPoint = .init(x: 1.0, y: 1.0)
        gradientLayer.endPoint   = .init(x: 0.0, y: 1.0)
    }
    
    private func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, mediumLocation as NSNumber, endLocation as NSNumber]
    }
    
    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, medium.cgColor, endColor.cgColor]
    }
}
