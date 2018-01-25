//
//  DownloadVoiceVC.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class DownloadVoiceVC: DownloadBaseVC, PushPlayerVC {

    fileprivate var dataSource = [DownloadVoiceModel]() {
        didSet {
            if dataSource.count == 0 {
                dataState = .emptyData
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
    }

}

//MARK:- 加载数据
extension DownloadVoiceVC {
    override func loadData() {
        super.loadData()
        self.dataState = .loadingData
        dataSource = DownloadDataTool.getDownloadedVoices()
        tableView.reloadData()
    }
}

//MARK:- 设置界面
extension DownloadVoiceVC {
    fileprivate func setupUI() {

    }
}

//MARK:- tableView代理
extension DownloadVoiceVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DownloadVoiceCell.cellWithTableView(tableView)
        let voiceM = dataSource[indexPath.row]
        DownloadingVoiceVM.setModelToCell(voiceM, cell)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let voiceM = dataSource[indexPath.row]
        pushPlayerVC(voiceM.albumId, voiceM.trackId,voiceM.downloadUrl)
    }
}




