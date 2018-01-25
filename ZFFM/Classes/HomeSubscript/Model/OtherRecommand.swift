//
//  OtherRecommand.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class OtherRecommand: NSObject {
    @objc var albumId = ""
    @objc var categoryId = ""
    @objc var title = ""
    @objc var intro = ""
    @objc var coverSmall = ""
    @objc var playsCounts = ""
    @objc var tracks = ""
    
    @objc var recommandCellHeight: CGFloat = 0
    override var description: String {
        return yy_modelDescription()
    }
}
