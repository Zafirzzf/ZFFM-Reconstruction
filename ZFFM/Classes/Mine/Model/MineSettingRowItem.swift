//
//  MineSettingRowItem.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
enum MineSettingArrowType {
    case defaultType
    case switchType
    case buttonType
}

class MineSettingRowItem {

    var image: UIImage?
    var title: String = ""
    var detailTitle: String = ""
    /// Arrow按钮上的title
    var arrowTitle: String?
    /// 要跳转的控制器名
    var className: String = ""
    
    
    var arrowType: MineSettingArrowType = MineSettingArrowType.defaultType
    
    init(_ image: UIImage? = nil, _ title: String = "", _ detailTitle: String = "") {
        self.image = image
        self.title = title
        self.detailTitle = detailTitle
        
    }

}




