//
//  PlayerGroupModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerGroupModel: NSObject {
    @objc var groupTitle = ""
    @objc var groupDetailTitle = ""
    @objc var albumInfoMs = [AlbumInfoModel]()
    @objc var albumId = ""
    
    init(title: String, subTitle: String, albumId: String, albumInfoMs: [AlbumInfoModel]) {
        super.init()
        self.groupTitle = title
        self.groupDetailTitle = subTitle
        self.albumId = albumId
        self.albumInfoMs = albumInfoMs
    }

    var totalCellHeight: CGFloat {
        return 30 * 2 + CGFloat(albumInfoMs.count) * (albumInfoMs.first ?? AlbumInfoModel()).cellHeight
    }
    
}
