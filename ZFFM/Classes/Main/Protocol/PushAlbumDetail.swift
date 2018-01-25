//
//  PushAlbumDetail.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
protocol PushAlbumDetail {
    
}
extension PushAlbumDetail {
    func pushAlbumDetailVC(_ albumId: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: KRecommandVCJumpToAlbumDetail), object: albumId)
    }
}
