//
//  ZFPlayerMoreListVC.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/9.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFPlayerMoreListVC: BaseViewController {


    @objc var listVM = PlayerMoreListVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
//MARK:- 加载数据
extension ZFPlayerMoreListVC {
    fileprivate func loadData() {
        listVM.loadData {
            self.tableView.reloadData()
        }
    }
}
//MARK:- 设置UI
extension ZFPlayerMoreListVC {
    fileprivate func setupUI() {
        navigationItem.title = listVM.title
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }
}
//MARK:- tableView协议
extension ZFPlayerMoreListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVM.isCommentList ? listVM.commentModels.count : listVM.recommendModels.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listVM.isCommentList {
            let cell = PlayerRecommendCommentCell.cellWithTableView(tableView)
            cell.commentInfo = listVM.commentModels[indexPath.row]
            return cell
        }else {
            let cell = PlayerRecommendAlbumCell.cellWithTableView(tableView)
            cell.albumInfo = listVM.recommendModels[indexPath.row]
            return cell
        }
    }
}
