//
//  ListenShareModel.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import YYModel
class ListenShareModel: NSObject {
    @objc var content = ""
    @objc var lengthLimit = 0
    @objc var picUrl = ""
    @objc var rowKey = ""
    @objc var shareType = ""
    @objc var subtitle = ""
    @objc var title = ""
    @objc var url = ""
    @objc var weixinPic = ""
    override var description: String {
        return yy_modelDescription()
    }
}
