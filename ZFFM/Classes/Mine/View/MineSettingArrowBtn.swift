//
//  MineSettingArrowBtn.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineSettingArrowBtn: UIButton {

    @objc convenience init(title: String,_ textColor: UIColor = KSubjectColor) {
        self.init(frame: CGRect.zero)
        titleLabel?.textColor = textColor
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sizeToFit()
    }

}
