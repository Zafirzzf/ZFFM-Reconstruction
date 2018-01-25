//
//  HomeAdvertiseCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/5.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class HomeAdvertiseCell: UITableViewCell,LoadNibCell {

    @IBOutlet weak var adContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upTitleLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @objc lazy var cycScrollView: ZFCycleScrollView = {
        let frame = CGRect(x: 0, y: 0, width: KSCREEN_W - 20, height: self.adContainerView.bounds.height)
        let cycscrollView = ZFCycleScrollView(frame: frame, delegate: self, placeHolderImage: nil)
        cycscrollView.currentPageDotColor = KSubjectColor
        return cycscrollView
        
    }()
    @objc var groupModel = HomeGroupModel() {
        didSet{
            isLiveModel = groupModel.liveMs.count > 0 ? true : false
            setupModel(groupModel)
        }
    }
    @objc var isLiveModel: Bool = true // 分Live模块和spread模块
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAdScrollView()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    @IBAction func moreBtnClick(_ sender: Any) {
        
    }
}
//MARK:- 设置UI
extension HomeAdvertiseCell {
    fileprivate func setupAdScrollView() {
        adContainerView.addSubview(cycScrollView)
    }
}

//MARK:- 界面赋值
extension HomeAdvertiseCell {
    fileprivate func setupModel(_ groupModel: HomeGroupModel) {
        titleLabel.text = groupModel.title
        rightTitleLabel.isHidden = !isLiveModel
        
        if isLiveModel { //是"现场直播"
            cycScrollView.picUrls = groupModel.liveMs.map{$0.coverPath}
            scrolledPageAndSetModel(groupModel.liveMs[0])
        }else { // "推广"
            cycScrollView.picUrls = groupModel.spreadMs.map {$0.cover}
            scrolledPageAndSetSpreadModel(model: groupModel.spreadMs[0])
        }

    }
}
//MARK:- scrollView代理
extension HomeAdvertiseCell: ZFCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: ZFCycleScrollView, didScrolledToItemIndex index: Int) {
        isLiveModel ? scrolledPageAndSetModel(groupModel.liveMs[index]) :
                      scrolledPageAndSetSpreadModel(model: groupModel.spreadMs[index])
    }
    fileprivate func scrolledPageAndSetModel(_ model: HomeLiveModel) {
        upTitleLabel.text = model.name
        detailTitleLabel.text = model.shortDescription
        if var count = Double(model.playCount) {
            if count > 10000.0 {
                count = count / 10000.0
                rightTitleLabel.text = String(format: "%.01f万人参与", count)
            }else {
                rightTitleLabel.text = String(format: "%zd人参与", count)
            }
        }
    }
    fileprivate func scrolledPageAndSetSpreadModel( model: HomeSpreadModel) {
        upTitleLabel.text = model.name
        detailTitleLabel.text = model.Description
    }
}




