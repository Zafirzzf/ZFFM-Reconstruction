//
//  MineProgramHeader.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineProgramHeader: UIView,LoadNibable {

    override func awakeFromNib() {
        super.awakeFromNib()
        frame = CGRect(x: 0, y: 0, width: KSCREEN_W, height: 150)
    }

}
