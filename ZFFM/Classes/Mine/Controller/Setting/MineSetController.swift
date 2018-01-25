//
//  MineSetController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineSetController: BaseSettingController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setListInfo()
        
        let exitLogin = UIButton(frame: CGRect(x: 0, y: 0, width: KSCREEN_W, height: 40))
        exitLogin.setTitle("退出登录", for: .normal)
        exitLogin.backgroundColor = KSubjectColor
        exitLogin.center = CGPoint(x: exitLogin.zf_width * 0.5, y: exitLogin.zf_height * 0.5)
        tableView.tableFooterView = exitLogin
    }

}

// MARK: - 加载数据
extension MineSetController {
    fileprivate func setListInfo() {
        title = "设置"
        setGroup1()
        setGroup2()
        setGroup3()
        setGroup4()
        setGroup5()
    }
    fileprivate func setGroup1() {
        let item1 = MineSettingRowItem(nil, "特色闹钟")
        item1.className = NSStringFromClass(SettingAlarmController.self)
        let item2 = MineSettingRowItem(nil, "定时关闭")
        let groupItem = MineSettingGroupItem([item1,item2])
        self.groupArray.append(groupItem)
    }
    fileprivate func setGroup2() {
        let item1 = MineSettingRowItem(nil, "账号绑定")
        let groupItem = MineSettingGroupItem([item1])
        self.groupArray.append(groupItem)
    }
    fileprivate func setGroup3() {
        let item1 = MineSettingRowItem(nil, "断点续听")
        item1.arrowType = .switchType
        let item2 = MineSettingRowItem(nil, "2G/3G/4G播放和下载")
        item2.arrowType = .switchType
        let item3 = MineSettingRowItem(nil, "清理占用空间")
        let item4 = MineSettingRowItem(nil, "推送设置")
        let item5 = MineSettingRowItem(nil, "隐藏设置")
        let groupItem = MineSettingGroupItem([item1, item2, item3, item4, item5])
        self.groupArray.append(groupItem)
    }
    fileprivate func setGroup4() {
        let item1 = MineSettingRowItem(nil, "帮助中心")
        let groupItem = MineSettingGroupItem([item1])
        self.groupArray.append(groupItem)
    }
    fileprivate func setGroup5() {
        let item1 = MineSettingRowItem(nil, "亲,请评价,支持我们做的更好")
        let item2 = MineSettingRowItem(nil, "关于")
        let groupItem = MineSettingGroupItem([item1,item2])
        self.groupArray.append(groupItem)
    }
}


extension MineSetController {
    
}



