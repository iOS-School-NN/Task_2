//
//  ColorSlider.swift
//  Task2
//
//  Created by Mary Matichina on 20.06.2021.
//

import UIKit

protocol ColorSliderDelegate {
    func colorSlider(_ colorSlider: ColorSlider,  didChangeValue value: CGFloat)
}

@IBDesignable final class ColorSlider: UIView {
     
    // MARK: - Properties
    
    private let maxHueValues = 360
    private let arrayHues = (0...359).map { $0 }
    private let thumb = UIView()
    private let sizeThumb: CGFloat = 40
    
    var delegate: ColorSliderDelegate?
    var thumbX: CGFloat?
    /// Set value from 20 to 339
    var hueValue: CGFloat = 0.5 {
        didSet {
            if hueValue > 19 && hueValue < 340 {
                let rowWidth = frame.width / CGFloat(maxHueValues)
                let xCoordinate = CGFloat(hueValue) * rowWidth
                thumbX = xCoordinate
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumb.center = CGPoint(x: thumbX ?? bounds.midX, y: bounds.midY)
        thumb.backgroundColor = getColorPoint(point: thumb.center)
    }
    
    // MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let rowWidth = frame.width / CGFloat(maxHueValues)
        
        for hue in arrayHues {
            let hueValue = CGFloat(hue) / CGFloat(maxHueValues)
            let color = UIColor(hue: hueValue, saturation: 1, brightness: 1, alpha: 1.0)
            context.setFillColor(color.cgColor)
            let xCoordinate = CGFloat(hue) * rowWidth
            context.fill(CGRect(x: xCoordinate, y: 0, width: rowWidth, height: frame.height))
        }
    }
    
    // MARK: - Configure
    
    private func configure() {
        thumbView()
        addGestureRecognizer()
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.clipsToBounds = true
    }
    
    private func thumbView() {
        thumb.layer.cornerRadius = sizeThumb * 0.5
        thumb.layer.bounds = CGRect(x: 0, y: 0, width: sizeThumb, height: sizeThumb)
        thumb.layer.shadowColor = UIColor.black.cgColor
        thumb.layer.shadowOffset = CGSize(width: 0.0, height: 6)
        thumb.layer.shadowRadius = 2.0
        thumb.layer.shadowOpacity = 0.25
        thumb.layer.borderColor = UIColor.white.cgColor
        thumb.layer.borderWidth = 1.5
        
        addSubview(thumb)
    }
    
    private func addGestureRecognizer() {
        let touchGesture = UIPanGestureRecognizer(target: self, action: #selector(thumbMove))
        thumb.addGestureRecognizer(touchGesture)
    }
    
    private func getColorPoint(point: CGPoint) -> UIColor {
        let hue = point.x / self.bounds.width
        return UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1.0)
    }
    
    @objc func thumbMove(sender: UIPanGestureRecognizer) {
        guard let superview = superview, let view = sender.view else { return }
        let translation = view.center.x + sender.translation(in: superview).x
        guard translation >= bounds.minX + (sizeThumb * 0.5), translation <= bounds.maxX - (sizeThumb * 0.5) else { return }
        view.center = CGPoint(x: translation, y: view.center.y)
        sender.setTranslation(CGPoint.zero, in: superview)
        
        let point = sender.location(in: self)
        let color = getColorPoint(point: point)
        self.thumb.backgroundColor = color
        let value = point.x / bounds.maxX
        
        delegate?.colorSlider(self, didChangeValue: value)
    }
}
