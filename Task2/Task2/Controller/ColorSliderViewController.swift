//
//  ColorSliderViewController.swift
//  Task2
//
//  Created by Mary Matichina on 20.06.2021.
//

import UIKit

class ColorSliderViewController: UIViewController {
    
    // MARK: Outlet
    
    @IBOutlet weak var slider: ColorSlider!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.delegate = self
        slider.hueValue = 270
    }
}

extension ColorSliderViewController: ColorSliderDelegate {
    func colorSlider(_ colorSlider: ColorSlider, didChangeValue value: CGFloat) {
        print(value)
    }
}
