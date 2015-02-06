//
//  FUXEasingCombinators.swift
//  FUX
//
//  Created by Garrit Schaap on 06.02.15.
//  Copyright (c) 2015 Garrit UG (haftungsbeschränkt). All rights reserved.
//

import UIKit

public func easeInCubic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in time * time * time }
}

public func easeOutCubic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in let t = time - 1.0; return t * t * t + 1 }
}

public func easeOutBounce(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)) { time in
        var t = time
        if t < 1.0 / 2.75 {
            return 7.5625 * t * t
        } else if t < 2.0 / 2.75 {
            t -= (1.5 / 2.75)
            return Float(7.5625 * t * t + 0.75)
        } else if t < 2.5 / 2.75 {
            t -= (2.25 / 2.75)
            return Float(7.5625 * t * t + 0.9375)
        } else {
            t -= (2.625 / 2.75)
            return Float(7.5625 * t * t + 0.984375)
        }
    }
}
