//
//  HomeRecommendVC.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/29.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
let KAdvertiseViewH: CGFloat = 150
let KMenuViewH: CGFloat = 3 * KCommonMargin +  KMenuBtnWidth
class HomeRecommendVC: BaseViewController {
    /* UI控件 */
    
    lazy var cycleScrollView: ZFCycleScrollView = {
        let frame = CGRect(x: 0, y: 0, width: KSCREEN_W, height: KAdvertiseViewH)
        let cycScrollView = ZFCycleScrollView(frame: frame, delegate: self)
        cycScrollView.currentPageDotColor = KSubjectColor
        return cycScrollView
    }()
    lazy var menuView: HomeMenuView = HomeMenuView(frame: CGRect(x: 0, y: KAdvertiseViewH, width: KSCREEN_W, height: KMenuViewH))
    /* 数据源 */
    var advertiseVM = HomeAdvertiseVM()
    var groupListVM = HomeGroupListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        registerNotfication()
    }

}

//MARK:- 加载数据
extension HomeRecommendVC {
    fileprivate func loadData() {
        // 广告栏 & 小编推荐
        loadAdvertiseAuthor()
        // 菜单列表
        loadMenuData()
        // 小编推荐
        loadEditorRecommond()
        // 现场直播
        loadLiveData()
        // 听广州
        loadCityAlbum()
        // 精品听单
        loadSpecialAlbum()
        // 推广
        loadSpreadAD()
        // 精品推荐
        loadHotRecommonds()
    
    }
    
    private func loadAdvertiseAuthor() {
        advertiseVM.loadAdversiseData { [weak self](success) in
            guard let picUrlArr = (self?.advertiseVM.advertises.map{$0.pic}) else {return}
            self?.cycleScrollView.picUrls = picUrlArr
        }
    }
    private func loadMenuData() {
        HomeRecommendRequest.loadPicMenuList { (resultDict, error) in
            let resultArr = resultDict!["discoveryColumns"]?["list"] as! [Any]
            self.menuView.menuModels = HomeMenuModel.mj_objectArray(withKeyValuesArray: resultArr) as! [HomeMenuModel]
            
            self.menuView.contentSize = CGSize(width: (KMenuLeftMargin + KMenuBtnWidth) * CGFloat(resultArr.count) + KMenuLeftMargin, height: KMenuViewH)
        }
    }
    private func loadEditorRecommond() {
        groupListVM.loadEditorRecommond( {
            self.tableView.reloadData()
            }
        )
    }
    private func loadLiveData() {
        groupListVM.loadLiveData {
            self.tableView.reloadData()
        }
    }
    private func loadCityAlbum() {
        groupListVM.loadCityAlbum {
            self.tableView.reloadData()
        }
    }
    private func loadSpecialAlbum() {
        groupListVM.loadSpecialAlbum {
            self.tableView.reloadData()
        }
    }
    private func loadSpreadAD() {
        groupListVM.loadSpreadData {
            self.tableView.reloadData()
        }
    }
    private func loadHotRecommonds() {
        groupListVM.loadHotRecommond {
            self.tableView.reloadData()
        }
    }
}

//MARK:- 注册通知
extension HomeRecommendVC {
    fileprivate func registerNotfication() {
        NotificationCenter.default.addObserver(self, selector: #selector(jumpToAlbumDetail(_:)), name: NSNotification.Name(rawValue: KRecommandVCJumpToAlbumDetail), object: nil)
    }
}

//MARK:- 事件响应
extension HomeRecommendVC {
    @objc func jumpToAlbumDetail(_ albumId: Notification) {
        let albumVC = AlbumDetailController()
        albumVC.albumId = albumId.object as! String
        navigationController?.pushViewController(albumVC, animated: true)
 
    }
}
//MARK:- 设置UI
extension HomeRecommendVC {
    fileprivate func setupUI() {
        initalizeTableView()
    }
    private func initalizeTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: KSCREEN_W, height: KSCREEN_H - 64-44-30)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_W, height: KAdvertiseViewH + KMenuViewH ))
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none 
        tableView.tableHeaderView?.addSubview(cycleScrollView)
        tableView.tableHeaderView?.addSubview(menuView)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
//MARK:- talbeView的代理数据源
extension HomeRecommendVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupListVM.groupModels.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        
        let group = groupListVM.groupModels[indexPath.row]
        switch group.cellType {
        case .CellTypeList3:
            let cell = HomeRecommendCell.cellWithTableView(tableView)
            cell.groupModel = group
            return cell
        case .CellTypeList1:
            let cell = HomeAdvertiseCell.cellWithTableView(tableView)
            cell.groupModel = group
            return cell
        case .CellTypeList2:
            let cell = HomeSpecialCell.cellWithTableView(tableView)
            cell.groupModel = group
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let group = groupListVM.groupModels[indexPath.row]
        switch group.cellType {
        case .CellTypeList1,.CellTypeList2:
            return 210
        case .CellTypeList3:
            return 240
        }
    }
}



//MARK:- 滚动栏代理
extension HomeRecommendVC: ZFCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: ZFCycleScrollView, didSelectItemAtIndex index: Int){
        let adModel = advertiseVM.advertises[index]
        switch adModel.type {
        case 9:
            print("听单处理")
        case 3:
            print("播放器界面")
        case 2:
            print("专辑详情")
            let albumVC = AlbumDetailController()
            albumVC.albumId = adModel.albumId
            navigationController?.pushViewController(albumVC, animated: true)
        case 4:
            print("打开网页")
        default:
            break;
        }
    }
}



