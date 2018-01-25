//
//  MineRootController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/4.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineRootController: BaseSettingController {
    // 控件
    fileprivate lazy var tableHeaderView: MineTableHeaderView = MineTableHeaderView.loadFromNib()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListInfo()
        setupUI()
        setupHeaderViewAction()

    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

// MARK: - 加载数据
extension MineRootController {
    fileprivate func loadListInfo() {
        setGroup1()
        setGroup2()
        setGroup3()
        setGroup4()
//        tableView.reloadData()
    }
    fileprivate func setGroup1() {
        let item1 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_notice_center"), "我的消息")
        item1.className = NSStringFromClass(MineMessageController.self)
        let group = MineSettingGroupItem([item1])
        groupArray.append(group)
    }
    fileprivate func setGroup2() {
        let item1 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_favAlbum"), "我的订阅")
        item1.className = NSStringFromClass(MineSubscribeController.self)
        let item2 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_liked"), "赞过的")
        item2.className = NSStringFromClass(MineLikedController.self)
        let group = MineSettingGroupItem([item1, item2])
        groupArray.append(group)
    }
    fileprivate func setGroup3() {
        let item1 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_boughttracks"), "已购声音")
        item1.className = NSStringFromClass(MineBoughtController.self)
        let item2 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_account"), "喜点余额")
        item2.className = NSStringFromClass(MineBalanceController.self)
        let group = MineSettingGroupItem([item1, item2])
        groupArray.append(group)
    }
    fileprivate func setGroup4() {
        let item1 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_union"), "免流量服务")
        let item2 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_findting"), "找好友")
        let item3 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_feedback"), "意见反馈")
        let item4 = MineSettingRowItem(#imageLiteral(resourceName: "me_setting_setting"), "设置")
        item4.className = NSStringFromClass(MineSetController.self)
        let group = MineSettingGroupItem([item1, item2, item3, item4])
        groupArray.append(group)

    }
}

// MARK: - 事件响应
extension MineRootController {
    fileprivate func setupHeaderViewAction() {
        tableHeaderView.recordBtnClick = { [weak self] in
            self?.navigationController?.pushViewController(RecorderController(), animated: true)
        }
        tableHeaderView.setupBtnClick = { [weak self] in
            self?.navigationController?.pushViewController(MineSetController(style: .grouped), animated: true)
        }
        tableHeaderView.itemListClick = { [weak self] in
            self?.navigationController?.pushViewController(MineProgramVC(style: .grouped), animated: true)
            
        }
    }
}

// MARK: - 设置UI
extension MineRootController {
    fileprivate func setupUI() {
        setupTableView()
        tableView.separatorStyle = .singleLine
        
    }
    fileprivate func setupTableView() {
        tableView.contentInset = UIEdgeInsetsMake(KOriHeight, 0, 0, 0)
        tableView.contentOffset.y = -KOriHeight

        tableHeaderView.frame = CGRect(x: 0, y: -KOriHeight * 1.1, width: KSCREEN_W, height: KOriHeight * 1.1)
        tableView.addSubview(tableHeaderView)
    }
}


// MARK: - tableView代理
fileprivate let KOriFrameY:CGFloat = 0
fileprivate let KOriHeight:CGFloat = 300

extension MineRootController {
    
    /// 滑动列表的时候
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offSet = scrollView.contentOffset.y
            if offSet < -KOriHeight {
                tableHeaderView.frame.origin.y = offSet * 1.1
                tableHeaderView.bounds.size.height = -offSet * 1.1
            }
    }
}








