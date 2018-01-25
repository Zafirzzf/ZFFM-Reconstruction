//
//  RewardModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class RewardModel: NSObject {
     @objc var id = ""
     @objc var uid = ""
     @objc var nickname = ""
     @objc var amount = ""
     @objc var paymentTime = ""
     @objc var sn = ""
     @objc var smallLogo = ""
    override var description: String {
        return yy_modelDescription()
    }
}
