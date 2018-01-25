//
//  HomeSpreadModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeSpreadModel: NSObject {
    @objc var shareData = ""
    @objc var isShareFlag = false
    @objc var link = ""
    @objc var cover = ""
    @objc var showstyle = 0
    @objc var name = ""
    @objc var Description = ""
    @objc var scheme = ""
    @objc var linkType = 0
    @objc var displayType = 0
    @objc var clickType = 0
    @objc var openlinkType = 0
    @objc var loadingShowTime = 0
    @objc var thirdStatUrl = ""
    @objc var apkUrl = ""
    @objc var adtype = ""
    @objc var auto = false
    @objc var position = 0
    @objc var adid = 0
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["Description" : "description"]
    }
    override var description: String {
        return yy_modelDescription()
    }
}
