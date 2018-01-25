//
//  TrackInfoModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class TrackInfoModel: NSObject {
    @objc var albumId = ""
    @objc var trackId = ""
    @objc var uid = ""
    @objc var playUrl64 = ""
    @objc var playUrl32 = ""
    @objc var playPathAacv164 = ""
    @objc var playPathAacv224 = ""
    @objc var title = ""
    @objc var duration = 0
    @objc var isPaid = false
    @objc var isFree = false
    @objc var isAuthorized = false
    @objc var sampleDuration = 0
    @objc var priceTypeEnum = ""
    @objc var likes = ""
    @objc var playtimes = ""
    @objc var comments = ""
    @objc var shares = ""
    @objc var status = ""
    @objc var categoryName = ""
    @objc var bulletSwitchType = ""
    @objc var playPathHq = ""
    @objc var shortRichIntro = ""
    
    @objc var images = [String]()

    
    override var description: String {
        return yy_modelDescription()
    }
}
