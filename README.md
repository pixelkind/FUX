# FUX
A functional tweening library for iOS written in Swift

![Smiley Tween](https://github.com/pixelkind/FUX/blob/master/Examples/Screenshots/SmileyTween.gif?raw=true)

After reading the great book about [Functional Programming in Swift](http://www.objc.io/books/) from the makers of objc.io during my travels through south-east-asia I was inspired to play around with functional programming and started writing my own small library.
And because I always write a tweening library sooner or later (see [GSTween](http://github.com/pixelkind/GSTween)) I started to write a functional tweening library for Swift. It uses a deep embedded purely functional data structure and an engine to run the tweens (for more infos about this kind of data structures have a look at the Diagrams Chapter in the book).

It is a first draft and not everything is implemented, but I am working on it. I like the style and flexibility you have with a functional tweening library. And please don't judge me for the overuse of my own operators, but I really like this feature in Swift....

Here are some code samples:

```swift
//Create a UIView that will bounce off the bottom of the screen
let tweenedView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
tweenedView.backgroundColor = UIColor.greenColor()
self.view.addSubview(tweenedView)

//Create a Tween with a duration of 2 seconds to change the frame of the view, the ~-operator calls a combinator for convenience
let viewTween = 2 ~ viewFrameValue(view: tweenedView, to: CGRect(x: 0, y: self.view.frame.size.height - 100, width: self.view.frame.size.width, height: 100))
//Add the Tween to the Engine (Runner)
engine.addTween(viewTween)

//Or easily add an ease-out-bounce to your tween
engine.addTween(easeOutBounce(viewTween))

//And now adding a 2 second delay
engine.addTween(2 >>> easeOutBounce(viewTween))
```

But there are a lot of possible scenarios you can use the tweening library and you don't have to use the combinators, you can create a Tween completely on your own:

```swift
//A linear, 10 second tween that just prints out it's tweenValue created without combinators or operators
let valueTween = FUXTween.Tween(10, FUXValue.Value({ tweenValue in println("TweenValue: \(tweenValue)") }))
engine.addTween(valueTween)
```

Next I will show you three different tweens with a linear easing, ease out sine and ease out bounce (there are many more easings supported). First we create a simple tween that goes just from left to right (the animal-view is placed at x = 10 and y = 100):

![Smiley Tween](https://github.com/pixelkind/FUX/blob/master/Examples/Screenshots/AnimalTweenLinear.gif?raw=true)

```swift
let linearTween = 2 ~ viewPositionValue(view: animal, to: CGPoint(x: 320, y: 100))
engine.addTween(linearTween)
```

Now we just add an easing Combinator to add a some smooth ease out:

![Smiley Tween](https://github.com/pixelkind/FUX/blob/master/Examples/Screenshots/AnimalTweenOutSine.gif?raw=true)

```swift
let linearTween = 2 ~ viewPositionValue(view: animal, to: CGPoint(x: 355 - animal.bounds.size.width, y: 100))
engine.addTween(easeOutSine(linearTween))
```

And if we change the easing to an ease out bounce this happens:

![Smiley Tween](https://github.com/pixelkind/FUX/blob/master/Examples/Screenshots/AnimalTweenOutBounce.gif?raw=true)

```swift
let linearTween = 2 ~ viewPositionValue(view: animal, to: CGPoint(x: 355 - animal.bounds.size.width, y: 100))
engine.addTween(easeOutBounce(linearTween))
```

More code examples and documentation will follow soon and can be found on my blog [www.garrit.io](https://www.garrit.io)...

Feel free to share your ideas and thoughts about this with me...

![Goodbye Tween](https://github.com/pixelkind/FUX/blob/master/Examples/Screenshots/FistTween.gif?raw=true)
