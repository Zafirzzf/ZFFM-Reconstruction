//
//  HomeItemCellModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/4.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeItemCellModel: NSObject {

    @objc var id = ""
    @objc var albumId = ""
    @objc var uid = ""
    @objc var intro = ""
    @objc var nickname = ""
    @objc var albumCoverUrl290 = ""
    @objc var coverSmall = ""
    @objc var coverMiddle = ""
    @objc var coverLarge = ""
    @objc var title = ""
    @objc var tags = ""
    @objc var tracks = ""
    @objc var playsCounts = ""
    @objc var isFinished = false
    @objc var serialState = ""
    @objc var trackId = ""
    @objc var trackTitle = ""
    @objc var isPaid = false
    @objc var commentsCount = ""
    @objc var priceTypeId = ""
    @objc var priceTypeEnum = ""
    @objc var columnType = ""
    @objc var specialId = ""
    @objc var subtitle = ""
    @objc var footnote = ""
    @objc var coverPath = ""
    @objc var contentType = ""
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    override var description: String {
        return yy_modelDescription()
    }
}

