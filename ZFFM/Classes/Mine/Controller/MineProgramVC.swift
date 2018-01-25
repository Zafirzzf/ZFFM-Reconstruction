//
//  MineProgramVC.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineProgramVC: BaseSettingController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setListInfo()
    }
}

extension MineProgramVC {
    fileprivate func setupUI() {
        title = "节目管理"
        tableView.tableHeaderView = MineProgramHeader.loadFromNib()
        tableView.separatorStyle = .singleLine
    }
}

extension MineProgramVC {
    fileprivate func setListInfo() {
        setGroup1()
        setGroup2()
        setGroup3()
    }
    private func setGroup1() {
        let item1 = MineSettingRowItem(nil, "我的声音")
        let item2 = MineSettingRowItem(nil, "我的专辑")
        let item3 = MineSettingRowItem(nil, "我的粉丝")
        let group = MineSettingGroupItem([item1,item2,item3])
        self.groupArray.append(group)
    }
    private func setGroup2() {
        let item1 = MineSettingRowItem(nil, "推荐指数排名")
        let item2 = MineSettingRowItem(nil, "我的收益")
        let item3 = MineSettingRowItem(nil, "更多服务")
        let group = MineSettingGroupItem([item1,item2,item3])
        self.groupArray.append(group)
    }
    private func setGroup3() {
        let item1 = MineSettingRowItem(nil, "节目攻略")
        let item2 = MineSettingRowItem(nil, "有声化平台")
        let group = MineSettingGroupItem([item1,item2])
        self.groupArray.append(group)
    }
}
