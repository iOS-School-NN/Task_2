//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Daria Tokareva on 22.06.2021.
//

import UIKit

protocol ColorPickerDelegate: UIViewController {
    func colorPicker(colorPicker: ColorPicker, hueValue: CGFloat)
}

class ColorPicker: UIView {

    var gradientView: UIView!
    var gradientLayer = CAGradientLayer()
    var thumbView: UIView!
    var chosenColor: UIColor = UIColor(hue: 0, saturation: 1, brightness: 1, alpha: 1)
    var currentHue: CGFloat?
    let hueColors = stride(from: 0, to: 1, by: 0.03).map {
        UIColor(hue: $0, saturation: 1, brightness: 1, alpha: 1).cgColor
    }
    weak var delegate: ColorPickerDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        constructColorPicker()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constructColorPicker()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .none
        resizeViews()
    }

    private func constructColorPicker() {
        constructGradientView()
        constructThumbView()
    }

    private func resizeViews() {
        gradientView.frame = CGRect(x: self.bounds.height / 2, y: self.bounds.minY,
                                    width: self.bounds.width - self.bounds.height, height: self.bounds.height)
        gradientLayer.frame = gradientView.bounds
        setThumbPositionByHue(hueValue: currentHue ?? 0)
        thumbView.frame = CGRect(x: thumbView.center.x, y: 0, width: self.bounds.height, height: self.bounds.height)
        chosenColor = UIColor(hue: getCurrentHue(xTranslation: thumbView.center.x ),
                              saturation: 1, brightness: 1, alpha: 1)
        thumbView.backgroundColor = chosenColor
    }

    private func constructGradientView() {
        gradientView = UIView(frame: CGRect(x: self.bounds.height / 2, y: self.bounds.minY,
                                            width: self.bounds.width - self.bounds.height,
                                            height: self.bounds.height))
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = hueColors
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)

        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        gradientView.layer.cornerRadius = gradientView.bounds.height / 2
        gradientView.clipsToBounds = true
        gradientView.layer.cornerRadius = gradientLayer.bounds.height / 2

        addSubview(gradientView)
    }

    private func constructThumbView() {
        thumbView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.height, height: self.bounds.height))
        thumbView.backgroundColor = chosenColor
        thumbView.layer.shadowColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
        thumbView.layer.shadowOpacity = 0.4
        thumbView.layer.shadowOffset = .zero
        thumbView.layer.shadowRadius = 6
        thumbView.layer.borderWidth = self.bounds.height * 0.1
        thumbView.layer.borderColor = UIColor.white.cgColor
        thumbView.layer.cornerRadius = thumbView.bounds.height / 2

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragTheView(sender:)))
        thumbView.addGestureRecognizer(panGestureRecognizer)
        addSubview(thumbView)
    }

    @objc private func dragTheView(sender: UIPanGestureRecognizer) {
        guard let superview = superview, let view = sender.view else { return }
        let translation = view.center.x + sender.translation(in: superview).x
        guard translation < self.bounds.width - self.bounds.height / 2 else {
            sender.setTranslation(CGPoint.zero, in: superview)
            return
        }
        guard translation > self.bounds.height / 2 else {
            sender.setTranslation(CGPoint.zero, in: superview)
            return

        }
        view.center = CGPoint(x: translation, y: view.center.y)
        chosenColor = UIColor(hue: getCurrentHue(xTranslation: thumbView.center.x ),
                              saturation: 1, brightness: 1, alpha: 1)
        thumbView.backgroundColor = chosenColor
        currentHue = getCurrentHue(xTranslation: thumbView.center.x)
        sender.setTranslation(CGPoint.zero, in: superview)

    }

    private func getCurrentHue(xTranslation: CGFloat) -> CGFloat {
        // 0.05 это погрешность, пока не поняла из-за чего возникает
        var result = xTranslation / gradientView.bounds.width - 0.05
        if result > 1 {
            result = 1
        } else if result < 0 {
            result = 0
        }
        delegate?.colorPicker(colorPicker: self, hueValue: result)
        return result
    }

    private func setThumbPositionByHue(hueValue: CGFloat) {
        thumbView.center.x = hueValue * gradientView.bounds.width
    }

    public func set(hueValue: CGFloat) {
        chosenColor = UIColor(hue: hueValue, saturation: 1, brightness: 1, alpha: 1)
        currentHue = hueValue
        thumbView.backgroundColor = chosenColor
        setThumbPositionByHue(hueValue: hueValue)
    }
}
