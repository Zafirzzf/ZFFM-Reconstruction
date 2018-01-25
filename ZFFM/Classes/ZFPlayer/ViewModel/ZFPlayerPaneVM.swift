//
//  ZFPlayerPaneVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/2.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFPlayerPaneVM {
    var headIcon = ""
    var nickName = ""
    var isShowVIcon = false
    var middleImage = ""
    var currentTime = "00:00"
    var totalTime = "00:00"
    var playUrlStr = ""
    /// 是否是从本地下载列表开始下载的
    var downloadUrl: String = ""
    init(trackModel: TrackInfoModel, userinfoModel: PlayerUserInfoModel) {
        headIcon = userinfoModel.smallLogo
        nickName = userinfoModel.nickname
        isShowVIcon = userinfoModel.isVerified
        middleImage = trackModel.images.first ?? ""
        playUrlStr = trackModel.playPathAacv164

        
        
    }
}
