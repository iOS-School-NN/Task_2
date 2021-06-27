//
//  SliderViewController.swift
//  Task2
//
//  Created by Grifus on 17.06.2021.
//

import UIKit

class SliderViewController: UIViewController {
    
    @IBOutlet weak var colorSlider: ThumbView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorSlider.delegate = self
    }
}

extension SliderViewController: SliderDelegate {
    func colorSlider(slider: ThumbView, hueVal: CGFloat) {
        print(hueVal)
    }
}
