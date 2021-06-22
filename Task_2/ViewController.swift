//
//  ViewController.swift
//  Task_2
//
//  Created by R S on 20.06.2021.
//

import UIKit

class ViewController: UIViewController {
   
    

    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var slider: UIView!
    @IBOutlet weak var sliderColor: UIView!
    
    private var colors = Array(0...359).map {
        UIColor(hue: CGFloat($0) / 359.0 ,
                      saturation: 1.0,
                      brightness: 1.0,
                      alpha: 1.0).cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.frame = sliderView.bounds
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0.0, y: 0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0)
        sliderView.layer.insertSublayer(gradient, at: 0)
        sliderView.layer.masksToBounds = true
        sliderView.layer.cornerRadius = 25
        slider.layer.cornerRadius = 20
        slider.layer.shadowColor = UIColor.black.cgColor
        slider.layer.shadowOpacity = 1
        slider.layer.shadowOffset = .zero
        slider.layer.shadowRadius = 5
        sliderColor.layer.cornerRadius = 18
        sliderColor.layer.backgroundColor = colors[colors.count / 2]
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragSlider))
        slider.addGestureRecognizer(panGestureRecognizer)
        // Do any additional setup after loading the view.
    }

    @objc func dragSlider(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .changed {
            let translation = recognizer.translation(in: sliderView)
            let newX = slider.center.x + translation.x
            slider.center = CGPoint(x: newX, y: slider.center.y)
            recognizer.setTranslation(CGPoint.zero, in: sliderView)
            sliderColor.layer.backgroundColor = UIColor(hue: recognizer.location(in: view).x / sliderView.frame.size.width, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
           
            if slider.center.x < 20 {
                slider.center = CGPoint(x: 20, y: slider.center.y)
            } else if slider.center.x > sliderView.frame.size.width - 20 {
                slider.center = CGPoint(x: sliderView.frame.size.width - 20, y: slider.center.y)
            }
        }
    }
}
