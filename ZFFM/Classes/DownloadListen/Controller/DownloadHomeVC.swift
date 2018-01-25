//
//  DownloadHomeVC.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import ZFPageTitleView
class DownloadHomeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
}
//MARK:- 设置UI
extension DownloadHomeVC {
    fileprivate func setupUI() {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: KSCREEN_H - 20)
        let childVCs = [DownloadAlbumVC(), DownloadVoiceVC(), DownloadingVC()]
        let pageView = ZFPageView(frame: frame, titles: ["专辑","声音","下载中"], childControllers: childVCs, parentVC: self)
        view.addSubview(pageView)
    }
}









