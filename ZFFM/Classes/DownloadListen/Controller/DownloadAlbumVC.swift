//
//  DownloadAlbumVC.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
class DownloadAlbumVC: DownloadBaseVC {

    @objc var dataSource = [DownloadAlbumModel]() {
        didSet {
            if dataSource.count == 0 {
                self.dataState = .emptyData
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
extension DownloadAlbumVC {
     override func loadData() {
        self.dataState = .loadingData
        dataSource = DownloadDataTool.getCurrentDownloadAlbum()
        tableView.reloadData()
    }
}


//MARK:- 设置UI
extension DownloadAlbumVC {
    fileprivate func setupUI() {

        
    }
}
//MARK:- emptyData 代理

//MARK:- tableView 代理
extension DownloadAlbumVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DownloadedAlbumCell.cellWithTableView(tableView)
        let albumModel = dataSource[indexPath.row]

        DownloadedAlbumVM.setModelToCell(albumModel, cell)
    
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumModel = dataSource[indexPath.row]
        let voiceListVC = VoiceListInAlbumVC()
        voiceListVC.albumModel = albumModel
        navigationController?.pushViewController(voiceListVC, animated: true)
    }
    
}




