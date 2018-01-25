//
//  PlayerUserInfoModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerUserInfoModel: NSObject {
         @objc var uid = ""
         @objc var nickname = ""
         @objc var isVerified = false
         @objc var smallLogo = ""
         @objc var followers = 0
         @objc var tracks = ""
         @objc var albums = ""
         @objc var ptitle = ""
         @objc var personDescribe = ""
    
    
    override var description: String {
        return yy_modelDescription()
    }
}
