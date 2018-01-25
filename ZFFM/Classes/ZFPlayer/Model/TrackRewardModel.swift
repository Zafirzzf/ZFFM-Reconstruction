//
//  TrackRewardModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class TrackRewardModel: NSObject {
    @objc var trackId = ""
    @objc var voiceIntro = ""
    @objc var uid = ""
    @objc var isOpen = false
    @objc var numOfRewards = ""
    @objc var rewords = [RewardModel]()
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["rewords" : RewardModel.self]
    }
    override var description: String {
        return yy_modelDescription()
    }
}
