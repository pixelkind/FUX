//
//  FUXEngine.swift
//  FUX
//
//  Created by Garrit Schaap on 03.02.15.
//  Copyright (c) 2015 Garrit UG (haftungsbeschränkt). All rights reserved.
//

import UIKit
import QuartzCore

infix operator + { associativity left}
public func + (l: FUXEngine, r: FUXTween) -> FUXTween {
    return l.addTween(r)
}

class FUXTweenStorage {
    let tween: FUXTween
    var totalRunningTime: Float = 0
    var currentTime: Float = 0
    var currentRelativeTime: Float = 0
    var currentTweenValue: Float = 0
    var speed: Float = 1
    var isFinished = false
    var repeatCount: Int = 0
    var repeatTotal: Int = 0
    var yoyo = false
    var speedSet = false
    var name = ""
    
    init(_ value: FUXTween, _ name: String) {
        self.tween = value
        self.name = name
    }
}

public class FUXEngine: NSObject {

    private var _displayLink: CADisplayLink!
    private var _tweens = [FUXTweenStorage]()
    private var _isRunning = false

    override public init () {
        super.init()
    }

    public func addTween(tween: FUXTween, name: String = "") -> FUXTween {
        let storedTween = FUXTweenStorage(tween, name)
        _tweens.append(storedTween)

        if (_tweens.count > 0 && !_isRunning) {
            setupDisplayLink()
        }
        return tween
    }
    
    public func removeTweenByName(name: String) {
        var index = 0
        for tween in _tweens {
            if tween.name == name {
                _tweens.removeAtIndex(index)
                break
            }
            index++
        }
        if _tweens.count == 0 && _isRunning {
            stopDisplayLink()
        }
    }
    
    public func pause() {
        stopDisplayLink()
    }
    
    public func resume() {
        setupDisplayLink()
    }
    
    private func setupDisplayLink() {
        _displayLink = CADisplayLink(target: self, selector: Selector("update:"))
        _displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        _isRunning = true
    }

    private func stopDisplayLink() {
        _displayLink.invalidate()
        _isRunning = false
    }

    func update(displayLink: CADisplayLink) {
        
        var index = 0
        for storedTween in _tweens {
            if !storedTween.isFinished {
                storedTween.totalRunningTime += Float(displayLink.duration) * Float(displayLink.frameInterval) * fabsf(storedTween.speed)
                storedTween.currentTweenValue = storedTween.currentRelativeTime
                parseTween(storedTween.tween, storedTween)
                index++
            } else  {
                _tweens.removeAtIndex(index)
            }
        }
        
        if (_tweens.count == 0 && _isRunning) {
            stopDisplayLink()
        }
    }
    
    private func parseTween(tween: FUXTween, _ storedTween: FUXTweenStorage) {
        
        switch tween {
            case .Tween(let duration, let value):
                parseValue(value, storedTween.currentTweenValue)
                var runFinished = false
                if storedTween.currentRelativeTime == 1 && storedTween.speed > 0 {
                    runFinished = true
                    if storedTween.repeatTotal > 0 {
                        storedTween.repeatCount++
                    }
                } else if storedTween.currentRelativeTime == 0 && storedTween.speed < 0 {
                    runFinished = true
                }
                
                storedTween.currentTime += Float(_displayLink.duration) * Float(_displayLink.frameInterval) * storedTween.speed
                let time = fmaxf(0, storedTween.currentTime) / duration
                let checkedTime = fminf(1, fmaxf(0, time))
                storedTween.currentRelativeTime = checkedTime
                
                if runFinished {
                    if !storedTween.yoyo {
                        if storedTween.repeatCount == storedTween.repeatTotal {
                            storedTween.isFinished = true
                        } else {
                            storedTween.totalRunningTime = 0
                            storedTween.currentRelativeTime = 0
                            storedTween.currentTime = 0
                        }
                    } else {
                        if storedTween.currentRelativeTime == 1 {
                            storedTween.speed *= -1
                            storedTween.currentRelativeTime = 1
                            storedTween.currentTime = duration
                        } else {
                            if storedTween.repeatCount == storedTween.repeatTotal {
                                storedTween.isFinished = true
                            }
                            storedTween.totalRunningTime = 0
                            storedTween.speed *= -1
                            storedTween.currentRelativeTime = 0
                            storedTween.currentTime = 0
                        }
                    }
                }
        case .Easing(let boxedTween, let easing):
            storedTween.currentTweenValue = easing(storedTween.currentTweenValue)
            parseTween(boxedTween.unbox, storedTween)
        case .Delay(let delay, let boxedTween):
            if storedTween.totalRunningTime > delay {
                parseTween(boxedTween.unbox, storedTween)
            }
        case .OnComplete(let boxedTween, let onComplete):
            if storedTween.currentRelativeTime == 1 {
                onComplete()
            }
            parseTween(boxedTween.unbox, storedTween)
        case .Repeat(let repeatTotal, let boxedTween):
            storedTween.repeatTotal = repeatTotal
            parseTween(boxedTween.unbox, storedTween)
        case .YoYo(let boxedTween):
            storedTween.yoyo = true
            parseTween(boxedTween.unbox, storedTween)
        case .Speed(let speed, let boxedTween):
            if !storedTween.speedSet {
                storedTween.speedSet = true
                storedTween.speed = speed
            }
            parseTween(boxedTween.unbox, storedTween)
        default:
            println("FUX Tween Engine")
        }
    }
    
    private func parseValue(value: FUXValue, _ tweenValue: Float) {
        
        switch value {
            case .Value(let valueFunc):
                valueFunc(tweenValue)
            case .Values(let values):
                for boxedValue in values {
                    parseValue(boxedValue.unbox, tweenValue)
                }
            default:
                println("FUX Tween Engine")
        }
    }

}