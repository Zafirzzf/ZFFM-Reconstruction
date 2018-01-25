//
//  MineBalanceController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineBalanceController: BaseSettingController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setListInfo()
    }
    
}
extension MineBalanceController {
    fileprivate func setListInfo() {
         title = "我的账号"
        setGroup1()
        setGroup2()
    }
    fileprivate func setGroup1() {
        let item1 = MineSettingRowItem(nil, "可用余额: 0 喜点")
        item1.arrowType = .buttonType
        item1.arrowTitle = "充值"
        let groupItem = MineSettingGroupItem([item1])
        self.groupArray.append(groupItem)
    }
    fileprivate func setGroup2() {
        let item1 = MineSettingRowItem(nil, "充值记录")
        item1.className = NSStringFromClass(SettingAlarmController.self)
        let item2 = MineSettingRowItem(nil, "消费记录")
        let groupItem = MineSettingGroupItem([item1,item2])
        self.groupArray.append(groupItem)
    }
}



