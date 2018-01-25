//
//  HomeSpecialCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
fileprivate let cellID = "cellID"
class HomeSpecialCell: UITableViewCell,LoadNibCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @objc var groupModel = HomeGroupModel() {
        didSet {
            titleLabel.text = groupModel.title
            self.tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTalbeCellInCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.rowHeight = 80
    }
    
    @IBAction func moreBtnClick(_ sender: Any) {
    }
}
//MARK:- tableView的代理
extension HomeSpecialCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupModel.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! HomeTalbeCellInCell
        cell.itemCellModel = groupModel.list[indexPath.row] as! HomeItemCellModel
        return cell
    }
    
}


