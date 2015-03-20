//
//  FUXData.swift
//  FUX
//
//  Created by Garrit Schaap on 03.02.15.
//  Copyright (c) 2015 Garrit UG (haftungsbeschränkt). All rights reserved.
//

import Foundation

public class Box<T> {
    let unbox: T
    public init(_ value: T) { self.unbox = value }
}

public enum FUXTween {
    case Tween(Float, FUXValue)
    case Easing(Box<FUXTween>, Float -> Float)
    case Delay(Float, Box<FUXTween>)
    case Speed(Float, Box<FUXTween>)
    case Reverse(Box<FUXTween>)
    case YoYo(Box<FUXTween>)
    case Repeat(Int, Box<FUXTween>)
    //case After(Box<FUXTween>, Box<FUXTween>)
    case OnComplete(Box<FUXTween>, () -> ())
    //case OnStart(Box<FUXTween>, () -> ())
    //case OnUpdate(Box<FUXTween>, (Float, Float) -> ())
}

public enum FUXValue {
    case Value(Float -> ())
    case Values([ Box<FUXValue> ])
}