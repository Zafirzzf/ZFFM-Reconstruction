//
//  PushPlayerVC.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/1.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

protocol PushPlayerVC {
    
}

extension PushPlayerVC {
    func pushPlayerVC(_ albumId: String, _ trackId: String, _ downloadUrl: String = "") {
        NotificationCenter.default.post(name: NSNotification.Name(KPresentPlayer), object: nil, userInfo: ["albumId" : albumId,
                            "trackId" : trackId,
                            "downloadUrl": downloadUrl])
    }
}
