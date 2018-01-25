//
//  CALayer+Extension.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/20.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
extension CALayer {
    @objc open func pauseAnimate() {
        let pauseTime = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pauseTime
    }
    
    @objc open func resumeAnimate() {
        let pauseTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0
        let timesincePause = convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        beginTime = timesincePause
    }
}
