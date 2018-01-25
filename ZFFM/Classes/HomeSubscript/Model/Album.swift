//
//  AlbumInfo.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class Album: NSObject {
    @objc var albumId = "";
    @objc var categoryId = "";
    @objc var title = "";
    @objc var categoryName = ""
    @objc var coverSmall = "";
    @objc var playTimes = "";
    @objc var nickname = "";
    override var description: String {
        return yy_modelDescription()
    }
}
