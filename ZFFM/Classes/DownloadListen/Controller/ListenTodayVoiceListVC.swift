//
//  ListenTodayVoiceListVC.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
fileprivate let cellID = "cellID"
class ListenTodayVoiceListVC: BaseViewController {

    var loadKey: String!
    var voiceMs: [DownloadVoiceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: KDownloadListChange), object: nil, queue: .main) { (noti) in
            self.tableView.reloadData()
        }
//        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: KDownloadListChange), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK:- 加载数据
extension ListenTodayVoiceListVC {
    fileprivate func loadData() {
        DownloadListenRequest.getVoiceMsWithKey(loadKey, 1) { (voiceMs) in
            self.voiceMs = voiceMs
            self.tableView.reloadData()
        }
    }
}

//MARK:- 设置UI
extension ListenTodayVoiceListVC {
    fileprivate func setupUI() {
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        
    }
}

//MARK:- tableView代理
extension ListenTodayVoiceListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voiceMs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListenTodayVoiceCell.cellWithTableView(tableView)
        let voiceModel = voiceMs[indexPath.row]
        voiceModel.sortNum = indexPath.row + 1
        ListenVoiceVM.setModelToCell(model: voiceModel, cell: cell)

        return cell
        
    }
}












