//
//  ZFPlayerVC.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFPlayerVC: BaseViewController {

    @objc static var shareInstance = ZFPlayerVC()
    private init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var playerVM = ZFPlayerVM()
    
    // 外部传递属性
     var albumId = ""
     var trackId = ""
    var downloadUrl: String?
    // 视图控件
    fileprivate lazy var playerPane: ZFPlayerPane = ZFPlayerPane.loadFromNib()
    
    fileprivate lazy var titleScrollView: ZFTitleScrollView = ZFTitleScrollView(frame: CGRect.zero)
    fileprivate lazy var rewardView: ZFRewardView = ZFRewardView.loadFromNib()

}

//MARK: 父类方法
extension ZFPlayerVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}


//MARK: 加载数据
extension ZFPlayerVC {
     @objc func loadData() {
        playerVM.getPlayerData(albumId, trackId) {[weak self] in
            // 设置头部
            let panVM = self?.playerVM.playerPanVM
            panVM?.downloadUrl = self?.downloadUrl ?? ""
            self?.playerPane.playerPaneVM = panVM
            self?.setTitleScrollView()
            self?.tableView.reloadData()
            self?.rewardView.trackRewardModel = (self?.playerVM.rewardInfoM)!
            
        }
    }
}

//MARK: 响应事件
extension ZFPlayerVC {
    
    @objc fileprivate func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
//MARK: 设置UI
extension ZFPlayerVC {
    fileprivate func setupUI() {
        
        setupNavigationBar()
        setupTableView()

    }
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(dismissView))
    }
    private func setupTableView() {
        tableView.delaysContentTouches = false
        tableView.tableHeaderView = playerPane
        

    }
    fileprivate func setTitleScrollView() {
        if navigationItem.titleView != nil {
            titleScrollView.title = playerVM.title
            return
        }
        titleScrollView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        titleScrollView.title = playerVM.title
        navigationItem.titleView = titleScrollView
    }
}
//MARK:- 对外方法
extension ZFPlayerVC {
    /// 数据重置
    @objc func resetData(_ albumId: String, _ trackId: String, _ downloadUrl: String?) {
        
        ZFRemotePlayer.shareInstance.stopPlay()
        playerPane.resetPlane()
        titleScrollView.title = ""
        playerVM = ZFPlayerVM()
        
        self.albumId = albumId
        self.trackId = trackId
        self.downloadUrl = downloadUrl
        loadData()
    }
}

//MARK: tableView代理
extension ZFPlayerVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = PlayerUserinfoCell.cellWithTableView(tableView)
            cell.albumVM = playerVM.albumInfoVM
            return cell
        case 1:
            let cell = PlayerRecommendCell.cellWithTableView(tableView)
            cell.playerGroupM = playerVM.recommendGroupM
            return cell
        case 2:
            let cell = PlayerRecommendCell.cellWithTableView(tableView)
            cell.playerCommentGroupM = playerVM.commentGroupM
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return playerVM.albumInfoVM?.cellHeight ?? 0
        case 1:
            return playerVM.recommendGroupM?.totalCellHeight ?? 0
        case 2:
            return playerVM.commentGroupM?.totalCellheight ?? 0
        default:
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return rewardView
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return rewardView.viewHeight
        }
        return 0
    }
    
    
}







