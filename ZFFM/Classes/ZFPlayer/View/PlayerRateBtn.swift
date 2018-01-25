//
//  PlayerRateBtn.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/23.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerRateBtn: UIButton {

    fileprivate lazy var rateStrs = ["x 1.0倍","x 1.5倍","x 2.0倍","x 0.5倍"]
    fileprivate lazy var rateNums = [1, 1.5, 2, 0.5]
    @objc var title = "" {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    @objc var rateIndex = 0
    @objc var rate: Float {
        return Float(rateNums[rateIndex])
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        title = rateStrs[rateIndex]
    }
    
    // 切换速率
    @objc func changeRate() {
        rateIndex += 1
        if rateIndex > rateNums.count - 1 {
            rateIndex = 0
        }
        title = rateStrs[rateIndex]
    }
    
}










