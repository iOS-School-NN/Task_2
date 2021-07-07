//
//  SliderViewController.swift
//  Task2
//
//  Created by Grifus on 17.06.2021.
//

import UIKit

class SliderViewController: UIViewController {
    
    @IBOutlet weak var colorSlider: SliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSlider.delegate = self
    }
}

extension SliderViewController: SliderDelegate {
    func colorSlider(slider: SliderView, didChange hueValue: CGFloat) {
        print(hueValue)
    }
}
