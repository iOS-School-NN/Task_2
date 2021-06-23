import UIKit

// Протокол делегата
protocol HueSliderDelegate: AnyObject {
    func hueSlider(_ hueSlider: HueSlider, didChangeValue value: CGFloat)
}

/*
 Класс описывает поведение и внешний вид слайдера для выбора HUE-значения (цветовой тон)
 Может быть использовн при работе с цветовым простраством HSV (HSB)
 Задать значение слайдеру: hueSlider.hueValue = *значение* или hueSlider.setValue(*значение*)
 Данный UI-элемент может быть добавлен на View с использованием Interface Builder
*/

@IBDesignable
final class HueSlider: UIView {

    // Толщина обводки ползунка (Настраиваемое свойство через Interface Builder)
    @IBInspectable
    var pickerBorderWidth: CGFloat {
        get {
            return picker.layer.borderWidth
        }
        set {
            picker.layer.borderWidth = newValue
        }
    }

    // Цвет обводки ползунка (Настраиваемое свойство через Interface Builder)
    @IBInspectable
    var pickerBorderColor: UIColor? {
        get {
            if let color = picker.layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                picker.layer.borderColor = color.cgColor
            } else {
                picker.layer.borderColor = nil
            }
        }
    }

    weak var delegate: HueSliderDelegate?

    private weak var gradientView: UIView!
    private weak var picker: UIView!

    // Текущее значение HUE
    var value: CGFloat = 0 {
        didSet {
            // Ограничение значений HUE (от 0 до 1 включительно)
            if value < 0 {
                value = 0
            } else if value > 1 {
                value = 1
            }

            // Обновляем цвет и положение пикера (ползунка)
            picker.center = CGPoint(x: bounds.width * value, y: picker.center.y)
            picker.backgroundColor = UIColor(hue: value, saturation: 1, brightness: 1, alpha: 1)
        }
    }

    // Реализация метода, который позволяет задать значение для слайдера
    func setValue(_ value: CGFloat) {
        self.value = value
    }

    // Настройка пикера (ползунка)
    private func configurePicker() {
        let picker = UIView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(hue: 0, saturation: 1, brightness: 1, alpha: 1)
        picker.layer.shadowRadius = 5
        picker.layer.shadowOpacity = 1
        picker.layer.shadowOffset = CGSize(width: 5, height: 5)

        addSubview(picker)

        NSLayoutConstraint.activate([
            picker.centerYAnchor.constraint(equalTo: centerYAnchor),
            picker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            picker.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            picker.centerXAnchor.constraint(equalTo: leadingAnchor)
        ])

        self.picker = picker

        // Добавление распознователя жестов (касаний)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pickerMoved(sender:)))
        addGestureRecognizer(panGestureRecognizer)
    }

    // Общая настройка градиент-подложки
    private func configureGradientView() {
        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.clipsToBounds = true

        addSubview(gradientView)

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            gradientView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        self.gradientView = gradientView
    }

    // Установка градиент-рисунка для подложки
    private func setGradient() {
        let gradientLayer = CAGradientLayer()

        // Создание набора цветов для HUE-слайдера с упором на 11 цветовых тонов
        let hueValues: [CGFloat] = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]
        let hueColors = hueValues.map({ (hue) -> CGColor in
            return UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1).cgColor
        })

        gradientLayer.colors = hueColors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientView.layer.addSublayer(gradientLayer)
    }

    // Метод обрабатывающий перемещение ползунка внутри слайдера
    @objc private func pickerMoved(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self).x + picker.center.x

        guard translation < bounds.width || translation > 0 else {
            sender.setTranslation(CGPoint.zero, in: superview)
            return
        }

        value = translation / bounds.width
        delegate?.hueSlider(self, didChangeValue: value)
        sender.setTranslation(CGPoint.zero, in: superview)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureGradientView()
        configurePicker()
        layoutIfNeeded()
        setGradient()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureGradientView()
        configurePicker()
        layoutIfNeeded()
        setGradient()

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientView.layer.cornerRadius = self.bounds.height / 2
        gradientView.layer.sublayers?.first?.frame = self.bounds
        picker.layer.cornerRadius = self.bounds.height * 0.45
        value += 0
    }
}
