# Task 2: UI Kit - Custom
## Приложение Hue Slider 

### Задача:
Создать слайдер в виде сабкласса UIView, который позволит пользователю выбирать Hue значение из цветового пространства HSBA.

### Условия:
1) В качестве подложки слайдер содержит градиент из спектра значений Hue.

![Screenshot 2021-06-17 at 00 47 27](https://user-images.githubusercontent.com/85530945/122298656-b3027180-cf05-11eb-9dc6-9e8690b38bfb.png)

2) Рычажок слайдера имеет вложенное UIView, его цвет меняется в зависимости от положения к градиентной подложке, показывая текущее значение Hue.

![Screenshot 2021-06-17 at 00 47 38](https://user-images.githubusercontent.com/85530945/122298706-c1e92400-cf05-11eb-8fcd-1acf578af7b6.png)

3) Рычажок слайдера использует UIPanGestureRecognizer для взаимодействия с пользователем.

4) В случае, если пользователь пытается перетащить рычажок за область градиента, то UIPanGestureRecognizer нужно прервать для этого жеста, либо отменить перемещение рычажка. В обычных ситуациях положение рычажка меняется только по горизонтали. 

5) Рычажок отбрасывает небольшую тень.

6) Data binding происходит с помощью протоколов делегата, т.е. UIViewController подписан на протокол делегата слайдера, и при изменении значения в метод делегата будет возвращаться CGFloat значение от 0 до 1.

Пример: (реализация методов и нейминг могут отличаться) 

```swift
class MyViewController: UIViewController { 

	override func viewDidLoad() { 

		super.viewDidLoad() 

		mySlider.delegate = self 

	} 

}

extension MyViewController: ColorSliderDelegate { 

	func colorSlider(_ colorSlider: ColorSlider,  didChangeValue value: CGFloat) { 

		print(value) // от 0.0 до 1.0,  

		//вызов print() проверит работоспособность метода делегата 
	}

}
```

7) Имеется возможность выставить CGFloat значение слайдера программно:

```swift
mySlider.hueValue = 0.5
```

либо  

```swift
mySlider.set(hueValue: 0.5)
```

положение рычажка тоже меняется в зависимости от установленного значения, метод делегата в таком случаи не срабатывает (чтобы избежать бесконечных рекурсивных вызовов).


8) Слайдер может быть добавлен в UIViewController программно, либо через Interface Builder (требуется реализация awakeFromNib и init)

9) Примерная иерархия view:

![Screenshot 2021-06-17 at 00 46 18](https://user-images.githubusercontent.com/85530945/122298477-7f274c00-cf05-11eb-83a9-29ea77397bfa.png)

10) Использовать Autolayout между parent и gradient view 


### Один из примеров итоговой работы:
![Screenshot 2021-06-17 at 00 44 31](https://user-images.githubusercontent.com/85530945/122298366-5737e880-cf05-11eb-983e-fce821f9b65f.png)
