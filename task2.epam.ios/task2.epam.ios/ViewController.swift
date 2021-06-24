//
//  ViewController.swift
//  task2.epam.ios
//
//  Created by XO on 21.06.2021.
//  Copyright © 2021 XO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let slider = MyRainbowView(frame: CGRect(x: 30, y: 200, width: 250, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.delegate = self
        self.view.addSubview(slider)
    }
}

extension ViewController : SliderDelegate {
    func colorSlider(slider: ThumbView, hueValue: CGFloat) {
        print(hueValue)
    }
}
