//
//  SliderViewController.swift
//  Task2
//
//  Created by Grifus on 17.06.2021.
//

import UIKit

class SliderViewController: UIViewController {
    
    @IBOutlet weak var colorSlider: ThumbView!

    @IBOutlet weak var gradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSlider.delegate = self
        createGradient()
    }
    
    private func createGradient() {
        let gradientLayer = CAGradientLayer()
        var colors = [CGColor]()
        gradientLayer.frame = gradientView.bounds
        for i in 0...360 {
            colors.append(UIColor(hue: CGFloat(Double(i) * 1 / 360), saturation: 1, brightness: 1, alpha: 1).cgColor)
        }
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.cornerRadius = gradientLayer.bounds.width * 0.05
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        view.sendSubviewToBack(gradientView)
    }
}

extension SliderViewController: SliderDelegate {
    func colorSlider(slider: ThumbView, hueVal: CGFloat) {
        print(hueVal)
    }
}
