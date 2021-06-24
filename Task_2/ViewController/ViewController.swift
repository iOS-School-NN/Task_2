//
//  ViewController.swift
//  Task_2
//
//  Created by KirRealDev on 22.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let slider = ColorSliderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        slider.colorSliderDelegate = self
    }
    
    private func configure() {
        slider.set(hueValue: 0.8)
        
        view.backgroundColor = .systemGray6
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }

}

extension ViewController: ColorSliderDelegate {
    func colorSlider(_ colorSlider: ColorSliderView,  didChangeValue value: CGFloat) {
        print("Current hueValue = ", value)
    }

}
