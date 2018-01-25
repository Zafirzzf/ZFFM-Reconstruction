//
//  AlbumDetailController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumDetailController: BaseViewController,PushPlayerVC {
    
    /* UI控件 */
    fileprivate lazy var headerView: AlbumDetailHeaderView = AlbumDetailHeaderView.loadFromNib()
    @objc open var albumId = ""
    /// segement当前选择索引
    @objc var selectedIndex = 0
    @objc var albumVM = AlbumDetailVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

//MARK:- 加载数据
extension AlbumDetailController {
    fileprivate func loadData() {
        
        //节目
        albumVM.getAlbumMenu(albumId) {[weak self] isSuccess in
            if isSuccess {
                self?.headerView.album = self?.albumVM.albumMenu.album
                self?.tableView.reloadData()
            }
        }
        
        // 详情
        albumVM.getAlbumDetail(albumId) { [weak self] isSuccess in
            if isSuccess {
                self?.tableView.reloadData()
            }
        }
        
    }
}

//MARK: 设置UI
extension AlbumDetailController {
    fileprivate func setupUI() {
        initTableView()
        navigationItem.title = "专辑详情"
    }
    private func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: KSCREEN_W, height: KSCREEN_H - 64), style: .plain)
        tableView.backgroundColor = KCommonBackcolor
        tableView.tableHeaderView = headerView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
}
//MARK:- segement代理
extension AlbumDetailController: ZFSegmentBarDelegate {
    @objc func segmentBar(_ segmentBar: ZFSegmentBar, index didSelectIndex: Int) {
        selectedIndex = didSelectIndex
        if selectedIndex == 1 {
            if albumVM.menuListArr.count > 0 {
                tableView.reloadData()
            }else {
                albumVM.getAlbumTrackList(albumId, { isSuccess in
                    if isSuccess {
                        self.tableView.reloadData()
                    }
                })
            }
        }else {
            tableView.reloadData()
        }
    }
}

//MARK:- tableView代理和数据源
extension AlbumDetailController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedIndex == 0 ? 4 : albumVM.menuListArr.count
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let segementView = ZFSegmentBar(frame: CGRect(x: 0, y: 0, width: KSCREEN_W, height: KMenueBarHeight), titles: ["详情","节目(21)"], delegate: self)
        segementView.backgroundColor = UIColor.white
        segementView.selectIndex = self.selectedIndex
        segementView.subjectColor = KSubjectColor
        return segementView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return KMenueBarHeight
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == 0 {
            switch indexPath.row {
            case 0:
                let detailInfo = self.albumVM.albumDetail.detail
                return detailInfo?.contentCellHeight ?? 0
            case 1:
                let anchorInfo = self.albumVM.albumDetail.user
                return anchorInfo?.anchorCellHeight ?? 0
            case 2:
                return 98
            case 3:
                return 420
            default:
                return 0
            }
            
        }else {
            guard albumVM.menuListArr.count > 0 else {return 0}
            let track = self.albumVM.menuListArr[indexPath.row]
            return track.cellHeight + 5
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedIndex == 0 {
            switch indexPath.row {
            case 0:
                let contentCell = AlbumDetailContentCell.cellWithTableView(tableView)
                contentCell.albumDetailInfo = self.albumVM.albumDetail.detail
                return contentCell
                
            case 1:
                let anchorCell = AlbumAnchorCell.cellWithTableView(tableView)
                anchorCell.anchorInfo = self.albumVM.albumDetail.user
                return anchorCell
            case 2:
                let tagCell = AlbumTagCell.cellWithTableView(tableView)
                return tagCell
                
            default:
                let recommendCell = AlbumRecommandCell.cellWithTableView(tableView)
                recommendCell.otherRecommands = self.albumVM.albumDetail.recs
                return recommendCell
            }
        }else {
            let trackCell = AlbumTrackCell.cellWithTableView(tableView)
            trackCell.trackModel = self.albumVM.menuListArr[indexPath.row]
            return trackCell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard selectedIndex == 1 else {return}
        let track = albumVM.menuListArr[indexPath.row]
        pushPlayerVC(track.albumId, track.trackId)
        
    }
}



