import UIKit

final class ColorViewController: UIViewController {

    @IBOutlet private weak var hueSlider: HueSlider!
    @IBOutlet private weak var colorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        hueSlider.delegate = self
        setColorViewHue(hueSlider.value)
    }

    private func setColorViewHue(_ value: CGFloat) {
        colorView.backgroundColor = UIColor(hue: value, saturation: 1, brightness: 1, alpha: 1)
    }
}

extension ColorViewController: HueSliderDelegate {
    func hueSlider(_ hueSlider: HueSlider, didChangeValue value: CGFloat) {
        setColorViewHue(value)
    }
}
