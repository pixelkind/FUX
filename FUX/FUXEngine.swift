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
public func + (l: FUXEngine, r: FUXTween) -> FUXTweenStorage {
    return l.addTween(r)
}

public class FUXTweenStorage {
    let tween: FUXTween
    var totalRunningTime: Float = 0
    var currentTime: Float = 0
    var currentRelativeTime: Float = 0
    var currentTweenValue: Float = 0
    var speed: Float = 1
    var isFinished = false
    
    init(_ value: FUXTween) { self.tween = value }
}

public class FUXEngine: NSObject {

    private var _displayLink: CADisplayLink!
    private var _tweens = [FUXTweenStorage]()
    private var _isRunning = false

    override public init () {
        super.init()
    }

    public func addTween(tween: FUXTween) -> FUXTweenStorage {
        let storedTween = FUXTweenStorage(tween)
        _tweens.append(storedTween)

        if (_tweens.count > 0 && !_isRunning) {
            setupDisplayLink()
        }
        return storedTween
    }
    
    private func setupDisplayLink() {
        _displayLink = CADisplayLink(target: self, selector: Selector("update:"))
        _displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
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
                storedTween.totalRunningTime += Float(displayLink.duration)
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
                if storedTween.currentRelativeTime == 1 {
                    storedTween.isFinished = true
                    //need repeat, yoyo, speed, ...
                }
                storedTween.currentTime += Float(_displayLink.duration)
                let time = (storedTween.currentTime) / duration
                let checkedTime = fminf(1, fmaxf(0, time))
                storedTween.currentRelativeTime = checkedTime
            case .Easing(let boxedTween, let easing):
                storedTween.currentTweenValue = easing(storedTween.currentRelativeTime)
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