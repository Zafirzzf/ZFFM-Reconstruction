//
//  MineSettingGroupItem.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineSettingGroupItem {

    var itemArr = [MineSettingRowItem]()
    var headerTitle: String?
    var footerTitle: String?
    
    init(_ itemArr: [MineSettingRowItem], _ headerTitle: String = "", _ footerTitle: String = "") {
        self.itemArr = itemArr
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
}
