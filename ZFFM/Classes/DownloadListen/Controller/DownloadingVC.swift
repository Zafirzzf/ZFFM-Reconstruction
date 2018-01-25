//
//  DownloadingVC.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class DownloadingVC: DownloadBaseVC {

    fileprivate var dataSource = [DownloadVoiceModel]() {
        didSet {
            if dataSource.count == 0 {
                self.dataState = .emptyData
            }
        }
    }
    fileprivate var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadData()
   
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateCell), userInfo: nil, repeats: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }



}

//MARK:- 加载数据
extension DownloadingVC {
    override func loadData() {
        self.dataSource = DownloadDataTool.getCurrentDownloadingVoices()
        tableView.reloadData()
    }

}

//MARK:- 事件响应
extension DownloadingVC {
    @objc fileprivate func updateCell() {
        let cells = tableView.visibleCells
        for (i,cell) in cells.enumerated() {
            let downloadModel = dataSource[i]
            DownloadingVoiceVM.setModelToCell(downloadModel, cell as! DownloadVoiceCell)
        }
    }
}

//MARK:- 设置界面
extension DownloadingVC {
    fileprivate func setupUI() {
 
        tableView.rowHeight = 90
        
    }
    override func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        switch dataState {
        case .emptyData:
            return UIImage(named: "noData_downloading")!
        case .loadingData:
            return #imageLiteral(resourceName: "loading.png")
        case .abnormal:
            return #imageLiteral(resourceName: "loading.png")
            
        }
    }
}


//MARK:- tableView代理
extension DownloadingVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DownloadVoiceCell.cellWithTableView(tableView)
        
        DownloadingVoiceVM.setModelToCell(dataSource[indexPath.row], cell)
        return cell
        
    }
}




