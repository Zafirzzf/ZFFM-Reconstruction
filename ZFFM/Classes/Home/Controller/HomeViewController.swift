//
//  HomeViewController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/27.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import ZFPageTitleView
class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "发现"
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK:- 设置UI
extension HomeViewController {
    fileprivate func setupUI() {
        let frame = CGRect(x: 0, y: 0, width: KSCREEN_W, height: KSCREEN_H - 64 - 44)
        let titles = ["推荐","分类","广播","榜单","主播"]
        let childControllers = [HomeRecommendVC(),TestViewControllera(),TestViewControllera(),TestViewControllera(),TestViewControllera()]
        let style = ZFPageStyle()
        style.scrollEnabled = false
        style.textNormalColor = UIColor(r: 201, g: 201, b: 201)
        style.textSelectColor = KSubjectColor
        style.titleFont = UIFont.boldSystemFont(ofSize: 13)
        let pageView = ZFPageView(frame: frame,
                                  titles: titles,
                                  childControllers: childControllers,
                                  parentVC: self,
                                  style: style)
        view.addSubview(pageView)
    }
   
}















