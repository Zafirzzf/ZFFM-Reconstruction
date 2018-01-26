//////    var dataSource = ["http://m4.pc6.com/xuh3/Snipmac205771.dmg", "http://m4.pc6.com/xuh3/itools291.dmg", "http://m5.pc6.com/xuh5/textbar20523.zip"]
//  ViewController.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/1.
//  Copyright © 2017年 周正飞. All rights reserved.

import UIKit
import ZFPageTitleView
class ListenTodayFireVC: BaseViewController {

    var downloadManager = ZFDownloadManager.shareInstance
    var categoryMs = [ListenCategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
    }

}

//MARK:- 加载数据
extension ListenTodayFireVC {
    fileprivate func loadData() {
        DownloadListenRequest.getTodayFireShareAndCategoryData { (shareModel, categoryMs) in
            self.categoryMs = categoryMs
            self.setupUI()
        }
    }
}

//MARK:- 设置UI
extension ListenTodayFireVC {
    fileprivate func setupUI() {
        title = "今日最火"
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        let titles = categoryMs.map{$0.name}
        var childVCs = [UIViewController]()
        for model in categoryMs {
            let voiceVC = ListenTodayVoiceListVC()
            voiceVC.loadKey = model.key
            childVCs.append(voiceVC)
        }
        let style = ZFPageStyle()
        let pageView = ZFPageView(frame: frame, titles: titles, childControllers: childVCs, parentVC: self, style: style)
        view.addSubview(pageView)
    }
}








