//
//  HomeLiveModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/5.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeLiveModel: NSObject {

    @objc var chatId = ""
    @objc var coverPath = ""
    @objc var endTs = ""
    @objc var id = ""
    @objc var name = ""
    @objc var onlineCount = ""
    @objc var playCount = ""
    @objc var scheduleId = ""
    @objc var shortDescription = ""
    @objc var startTs = ""
    @objc var status = ""
    override var description: String {
        return yy_modelDescription()
    }
}
