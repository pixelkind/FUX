//
//  FUXCombinators.swift
//  FUX
//
//  Created by Garrit Schaap on 04.02.15.
//  Copyright (c) 2015 Garrit UG (haftungsbeschränkt). All rights reserved.
//

import UIKit

infix operator >>> { associativity left }
public func >>> (l: Float, r: FUXTween) -> FUXTween {
    return FUXTween.Delay(l, Box(r))
}

infix operator ~ { associativity left }
public func ~ (l: Float, r: FUXValue) -> FUXTween {
    return tween(duration: l, value: r)
}

infix operator + { associativity left }
public func + (l: FUXValue, r: FUXValue) -> FUXValue {
    return FUXValue.Values([ Box(l), Box(r) ])
}

infix operator >>| { associativity left }
public func >>| (l: FUXTween, r: () -> ()) -> FUXTween {
    return createOnComplete(l, r)
}


public func tween(#duration: Float, #value: FUXValue) -> FUXTween {
    return FUXTween.Tween(duration, value)
}

public func delayedTween(#delay: Float, #tween: FUXTween) -> FUXTween {
    return FUXTween.Delay(delay, Box(tween))
}

public func createDelayedTween(#duration: Float, #delay: Float, #value: FUXValue) -> FUXTween {
    return FUXTween.Delay(delay, Box(FUXTween.Tween(duration, value)))
}

public func createValue(value: Float -> ()) -> FUXValue {
    return FUXValue.Value(value)
}

public func createOnComplete(tween: FUXTween, onComplete: () -> ()) -> FUXTween {
    return FUXTween.OnComplete(Box(tween), onComplete)
}

public func fromToPoint(#from: CGPoint, #to: CGPoint, #valueFunc: CGPoint -> ()) -> FUXValue {
    return FUXValue.Value({ tweenValue in valueFunc(CGPoint(x: from.x + (to.x - from.x) * CGFloat(tweenValue), y: from.y + (to.y - from.y) * CGFloat(tweenValue))) })
}

// this is not working :(
/*
public func fromToValue(inout value: Float, #from: Float, #to: Float) -> FUXValue {
    return FUXValue.Value({ tweenValue in value = from + (to - from) * tweenValue; println("\(tweenValue) - \(from) - \(to) -> \(value)") })
}
*/

public func fromToValueFunc(#from: Float, #to: Float, valueFunc: Float -> ()) -> FUXValue {
    return FUXValue.Value({ tweenValue in valueFunc(from + (to - from) * tweenValue) })
}

public func viewFrameValue(#view: UIView, #to: CGRect) -> FUXValue {
    let from = view.frame
    let change = CGRect(x: to.origin.x - from.origin.x, y: to.origin.y - from.origin.y, width: to.size.width - from.size.width, height: to.size.height - from.size.height)
    return FUXValue.Value({ tweenValue in
        let x = from.origin.x + change.origin.x * CGFloat(tweenValue)
        let y = from.origin.y + change.origin.y * CGFloat(tweenValue)
        let width = from.size.width + change.size.width * CGFloat(tweenValue)
        let height = from.size.height + change.size.height * CGFloat(tweenValue)
        view.frame = CGRect(x: x, y: y, width: width, height: height) })
}

public func constraintValue(#view: UIView, #constraint: NSLayoutConstraint, #constant: CGFloat) -> FUXValue {
    let from = constraint.constant
    let change = constant - constraint.constant
    return FUXValue.Value({ tweenValue in constraint.constant = from + change * CGFloat(tweenValue); view.layoutIfNeeded() })
}
