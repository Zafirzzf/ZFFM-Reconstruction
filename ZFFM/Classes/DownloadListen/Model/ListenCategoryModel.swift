//
//  ListenCategoryModel.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ListenCategoryModel: NSObject {
    @objc var id = 0
    @objc var key = ""
    @objc var name = ""
    override var description: String {
        return yy_modelDescription()
    }
}
