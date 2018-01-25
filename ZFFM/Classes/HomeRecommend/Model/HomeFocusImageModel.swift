//
//  HomeFocusImageModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/13.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeFocusImageModel: NSObject {
    @objc var id = 0
    @objc var shortTitle = ""
    @objc var longTitle = ""
    @objc var pic = ""
    
    @objc var type = 0
    @objc var uid = 0
    @objc var albumId = 0
    @objc var trackId = 0
    @objc var isShare = false
    @objc var is_External_url = false
    @objc var url = ""
}
