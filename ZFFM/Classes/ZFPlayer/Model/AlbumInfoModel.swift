//
//  AlbumInfoModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumInfoModel: NSObject {
    @objc var albumId = ""
    @objc var categoryId = ""
    @objc var title = ""
    @objc var coverOrigin = ""
    @objc var coverSmall = ""
    @objc var coverMiddle = ""
    @objc var coverLarge = ""
    @objc var coverWebLarge = ""
    @objc var createAt = ""
    @objc var updateAt = ""
    @objc var  uid = ""
    @objc var intro = ""
    @objc var tags = ""
    @objc var tracks = "40"
    @objc var shares: CGFloat = 0
    @objc var hasNew = false
    @objc var isFavorite = false
    @objc var playTimes = ""
    @objc var playsCounts = "1.2万"
    @objc var isPaid = false
    @objc var status = 0
    @objc var serializeStatus = 0
    @objc var cellHeight: CGFloat = 70

}
