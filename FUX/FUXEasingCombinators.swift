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
    return FUXTween.Easing(Box(tween)){ time in
        let t = time - 1.0
        return t * t * t + 1
    }
}

public func easeInOutCubic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        var t = time * 2
        if t < 1 {
            return 0.5 * t * t * t
        }
        t -= 2
        return 0.5 * (t * t * t + 2)
    }
}


public func easeInCircular(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in -(sqrtf(1 - time * time) - 1) }
}

public func easeOutCircular(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        let t = time - 1.0
        return sqrtf(1 - t * t)
    }
}

public func easeInOutCircular(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        var t = time * 2
        if t < 1 {
            return -0.5 * (sqrtf(1 - t * t) - 1)
        }
        t -= 2
        return 0.5 * (sqrtf(1 - t * t) + 1)
    }
}


public func easeInSine(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in 1 - cosf(time * Float(M_PI_2)) }
}

public func easeOutSine(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in sinf(time * Float(M_PI_2)) }
}

public func easeInOutSine(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in -0.5 * (cosf(Float(M_PI) * time) - 1) }
}


public func easeInQuadratic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in time * time }
}

public func easeOutQuadratic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in -time * (time - 2) }
}

public func easeInOutQuadratic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        var t = time * 2
        if t < 1 {
            return 0.5 * t * t
        }
        return -0.5 * (--t * (t - 2) - 1)
    }
}


public func easeInQuartic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in time * time * time * time }
}

public func easeOutQuartic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        let t = time - 1
        return -(t * t * t * t - 1)
    }
}

public func easeInOutQuartic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        var t = time * 2
        if t < 1 {
            return 0.5 * t * t * t * t
        }
        t -= 2
        return -0.5 * (t * t * t * t - 2)
    }
}


public func easeInQuintic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in time * time * time * time * time }
}

public func easeOutQuintic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        let t = time - 1
        return -(t * t * t * t * t - 1)
    }
}

public func easeInOutQuintic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        var t = time * 2
        if t < 1 {
            return 0.5 * t * t * t * t * t
        }
        t -= 2
        return -0.5 * (t * t * t * t * t - 2)
    }
}


public func easeInExpo(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in time == 0 ? 0 : powf(2, 10 * (time - 1)) }
}

public func easeOutExpo(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in time == 1 ? 1 : -powf(2, -10 * time) + 1 }
}

public func easeInOutExpo(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        if time == 0 {
            return 0
        } else if time == 1 {
            return 1
        }
        var t = time * 2
        if t < 1 {
            return 0.5 * powf(2, 10 * (t - 1))
        } else {
            return 0.5 * (-powf(2, -10 * --t) + 2)
        }
    }
}


let easeBackSValue: Float = 1.70158;

public func easeInBack(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in time * time * ((easeBackSValue + 1) * time - easeBackSValue) }
}

public func easeOutBack(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        let t = time - 1
        return t * t * ((easeBackSValue + 1) * t + easeBackSValue) + 1
    }
}

public func easeInOutBack(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)){ time in
        var t = time * 2
        let s = easeBackSValue * 1.525
        if t < 1 {
            return 0.5 * (t * t * ((s + 1) * t - s))
        }
        t -= 2
        return 0.5 * (t * t * ((s + 1) * t + s) + 2)
    }
}


public func easeInBounce(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)) { time in
        var t = 1 - time
        if t < 1.0 / 2.75 {
            return 1 - 7.5625 * t * t
        } else if t < 2.0 / 2.75 {
            t -= (1.5 / 2.75)
            return 1 - Float(7.5625 * t * t + 0.75)
        } else if t < 2.5 / 2.75 {
            t -= (2.25 / 2.75)
            return 1 - Float(7.5625 * t * t + 0.9375)
        } else {
            t -= (2.625 / 2.75)
            return 1 - Float(7.5625 * t * t + 0.984375)
        }
    }
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

public func easeInOutBounce(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)) { time in
        var t = time * 2
        if t < 1 {
            return (1 - easeOutBounceWithTime(1 - t, 1)) * 0.5
        } else {
            return easeOutBounceWithTime(t - 1, 1) * 0.5 + 0.5
        }
    }
}

func easeOutBounceWithTime(time: Float, duration: Float) -> Float {
    var t = time / duration
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


var easeElasticPValue: Float = 0.3
var easeElasticSValue: Float = 0.3 / 4
var easeElasticAValue : Float = 1

public func easeInElastic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)) { time in
        if time == 0 {
            return 0
        } else if time == 1 {
            return 1
        }
        let t = time - 1
        return -(powf(2, 10 * t) * sinf((t - easeElasticSValue) * (Float(M_PI) * 2) / easeElasticPValue))
    }
}

public func easeOutElastic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)) { time in
        if time == 0 {
            return 0
        } else if time == 1 {
            return 1
        }
        return powf(2, (-10 * time)) * sinf((time - easeElasticSValue) * (Float(M_PI) * 2) / easeElasticPValue) + 1
    }
}

public func easeInOutElastic(tween: FUXTween) -> FUXTween {
    return FUXTween.Easing(Box(tween)) { time in
        if time == 0 {
            return 0
        } else if time == 1 {
            return 1
        }
        var t = time * 2
        if t < 1 {
            t -= 1
            return -0.5 * (powf(2, 10 * t) * sinf((t - easeElasticSValue) * (Float(M_PI) * 2) / easeElasticPValue))
        }
        t -= 1
        return powf(2, -10 * t) * sinf((t - easeElasticSValue) * (Float(M_PI) * 2) / easeElasticPValue) * 0.5 + 1
    }
}