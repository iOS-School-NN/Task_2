//
//  ViewController.swift
//  HueSlider
//
//  Created by Alexander on 18.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        colorSlider.hueValue = 0.5
    }
    
    private lazy var colorSlider: ColorSlider = {
        let slider = ColorSlider()
        slider.delegate = self
        return slider
    }()
    
    private func configure() {
        view.backgroundColor = .systemTeal
        view.addSubview(colorSlider)
        colorSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            colorSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            colorSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            colorSlider.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension ViewController: ColorSliderDelegate {
    func colorSlider(_ colorSlider: ColorSlider, didChangeValue value: CGFloat) {
        print(value)
    }
}

