//
//  PlayerRecommendCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerRecommendCell: UITableViewCell,LoadNibCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subDescriptionLabel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var playerGroupM: PlayerGroupModel? {
        didSet {
            titleLabel.text = playerGroupM?.groupTitle
            subDescriptionLabel.setTitle(playerGroupM?.groupDetailTitle, for: .normal)
            self.tableView.reloadData()
        }
    }
    var playerCommentGroupM: PlayerCommentGroupModel? {
        didSet {
            titleLabel.text = playerCommentGroupM?.groupTitle
            subDescriptionLabel.setTitle(playerCommentGroupM?.groupDetailTitle, for: .normal)  
            self.tableView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.reloadData()
    }
    
    @IBAction func MoreBtnClick(_ sender: UIButton) {
        let moreList = ZFPlayerMoreListVC()
        let moreListVM = PlayerMoreListVM()
        if playerGroupM != nil {
            moreListVM.albumId = playerGroupM!.albumId
            moreListVM.title = playerGroupM!.groupTitle
        }else {
            guard let commentModels = playerCommentGroupM else {return}
            moreListVM.trackId = commentModels.trackId
            moreListVM.title = commentModels.groupTitle
        }
        moreList.listVM = moreListVM
        ZFPlayerVC.shareInstance.navigationController?.pushViewController(moreList, animated: true)
        
    }
    
    
}

//MARK:- tableView代理
extension PlayerRecommendCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playerGroupM == nil && playerCommentGroupM == nil {
            return 0
        }
        return (playerGroupM != nil ? playerGroupM?.albumInfoMs.count : playerCommentGroupM?.commentInfoMs.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if playerGroupM != nil { // 相关推荐
            
            let cell = PlayerRecommendAlbumCell.cellWithTableView(tableView)
            cell.albumInfo = playerGroupM?.albumInfoMs[indexPath.row]
            return cell
        }else {  // 评论列表
            let cell = PlayerRecommendCommentCell.cellWithTableView(tableView)
            cell.commentInfo = playerCommentGroupM?.commentInfoMs[indexPath.row]
            return cell
        }
    }
}


