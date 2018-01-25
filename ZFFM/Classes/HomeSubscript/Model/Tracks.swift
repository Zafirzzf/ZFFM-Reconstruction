//
//  Tracks.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class Tracks: NSObject {
    @objc var list:[TrackInfo] = []
    @objc var pageId = ""
    @objc var pageSize = ""
    @objc var maxPageId = ""
    @objc var totalCount = ""
    override var description: String {
        return yy_modelDescription()
    }
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list" : TrackInfo.self]
    }
}
