//
//  AlbumDetailInfo.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumDetailInfo: NSObject {
    @objc var albumId = ""
    @objc var intro = ""
    @objc var introRich = ""
    @objc var tags = ""
    override var description: String {
        return yy_modelDescription()
    }
    var contentCellHeight: CGFloat {
        var height: CGFloat = 37.0
        let textH = (self.intro as NSString).boundingRect(with: CGSize(width: KSCREEN_W - 30, height: 10000), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)], context: nil).height
        height = height + textH + 40.0
        return height
    }
}
