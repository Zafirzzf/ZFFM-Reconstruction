//
//  TrackInfo.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class TrackInfo: NSObject {
    @objc var trackId = ""
    @objc var uid = ""
    @objc var playUrl64 = ""
    @objc var playUrl32 = ""
    @objc var playPathAacv164 = ""
    @objc var playPathAacv224 = ""
    @objc var title = ""
    @objc var duration = 0.0
    @objc var albumId = ""
    @objc var isPaid = false
    @objc var createdAt = ""
    @objc var coverSmall = ""
    @objc var coverMiddle = ""
    @objc var coverLarge = ""
    @objc var smallLogo = ""
    @objc var isPublic = false
    @objc var like = ""
    @objc var playtimes = 0.0
    @objc var comments = ""
    @objc var shares = 0.0
    @objc var status = 0
    
    override var description: String {
        return yy_modelDescription()
    }
    @objc var cellHeight:CGFloat = 0.0
}
