//
//  ViewController.swift
//  Task_2
//
//  Created by R S on 20.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let slider = ColorSlider()
        slider.delegate = self
        slider.hue = 0.5
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension ViewController: ColorSliderDelegate {
    func colorSlider(_ colorSlider: ColorSlider, didChangeValue value: CGFloat) {
        print(value)
    }
}
