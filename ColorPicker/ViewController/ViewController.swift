//
//  ViewController.swift
//  ColorPicker
//
//  Created by Daria Tokareva on 22.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myColorPicker: ColorPicker!
    var progmmaticallyAddedColorPicker = ColorPicker(frame: CGRect(x: 60, y: 120, width: 320, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()

        myColorPicker.delegate = self
        myColorPicker.set(hueValue: 0.8)

        progmmaticallyAddedColorPicker.delegate = self
        self.view.addSubview(progmmaticallyAddedColorPicker)
        progmmaticallyAddedColorPicker.set(hueValue: 0.35)
    }
}
extension ViewController: ColorPickerDelegate {
    func colorPicker(colorPicker: ColorPicker, hueValue: CGFloat) {
        print("hue: \(hueValue)")
    }
}
