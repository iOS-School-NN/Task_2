//
//  ViewController.swift
//  Hue Slider
//
//  Created by Step ToVictory on 01.07.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let slider = ThumbView()
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


extension ViewController: ThumbViewDelegate {
    func thumbView(_ colorSlider: ThumbView, didChangeValue value: CGFloat) {
        print(value)
    }
}

