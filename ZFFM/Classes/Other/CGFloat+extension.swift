//
//  CGFloat+extension.swift
//  ZFFM
//
//  Created by 周正飞 on 2018/1/25.
//  Copyright © 2018年 周正飞. All rights reserved.
//

import UIKit
infix operator % :AdditionPrecedence
extension CGFloat {
    static  func % (_ left: CGFloat, _ right: CGFloat) -> CGFloat {
        return left.truncatingRemainder(dividingBy: right)
    }
    mutating func roundToInt() -> Int {
        round()
        return Int(self)
    }
}
