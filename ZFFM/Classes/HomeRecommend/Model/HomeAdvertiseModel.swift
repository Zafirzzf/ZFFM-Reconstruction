//
//  HomeAdvertiseModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeAdvertiseModel: NSObject {
    @objc var focusCurrentId = 0
    @objc var id: String = ""
    @objc var longTitle = ""
    @objc var pic = ""
    @objc var type = 0
    @objc var uid = ""
    
    @objc var albumId = ""
    @objc var trackId = ""
    @objc var url = ""
//    var focusImageM = HomeFocusImageModel()
//    var liveM = HomeLiveModel()
//    var spreadM = HomeSpreadModel()
//    var
    
    override var description: String {
        return yy_modelDescription()
    }
}
