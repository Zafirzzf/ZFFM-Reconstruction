//
//  AlbumRecommandCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/22.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class AlbumRecommandCell: UITableViewCell, LoadNibCell, PushAlbumDetail {

    @IBOutlet weak var talbeView: UITableView!
    @objc var otherRecommands: OtherRecommands? {
        didSet {
            talbeView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        initView()
    }

    fileprivate func initView() {
        talbeView.delegate = self
        talbeView.dataSource = self
        talbeView.rowHeight = 100
        talbeView.isScrollEnabled = false

    }
    
}
//MARK:- tableView数据源代理
extension AlbumRecommandCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherRecommands?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AlbumRecommondsCell.cellWithTableView(tableView)
        if otherRecommands != nil {
            cell.recommend = otherRecommands!.list[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recommend = otherRecommands!.list[indexPath.row]
        pushAlbumDetailVC(recommend.albumId)
    }
}





