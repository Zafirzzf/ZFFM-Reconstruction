//
//  AlbumDetail.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumDetail: NSObject {
    @objc var detail: AlbumDetailInfo?
    @objc var user: AnchorInfo?
    @objc var recs: OtherRecommands?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["detail" : AlbumDetailInfo.self,
                "user" : AnchorInfo.self,
                "recs" : OtherRecommands.self]
    }
    override var description: String {
        return yy_modelDescription()
    }
}
