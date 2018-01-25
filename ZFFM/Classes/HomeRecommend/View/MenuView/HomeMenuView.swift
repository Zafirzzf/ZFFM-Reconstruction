//
//  HomeMenusView.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

let KMenuBtnWidth: CGFloat = 60
let KMenuLeftMargin: CGFloat = 20
class HomeMenuView: UIScrollView {
    
    @objc var menuModels = [HomeMenuModel]() {
        didSet {
            setupUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI
extension HomeMenuView {
    fileprivate func setupUI() {
        initalize()
        addButtons()
    }
    private func initalize() {
        showsHorizontalScrollIndicator = false
        backgroundColor = UIColor.white
    }
    private func addButtons() {
        for (index,model) in menuModels.enumerated() {
            let x = KMenuLeftMargin + CGFloat(index) * (KMenuBtnWidth + KMenuLeftMargin)
            let button = MenuUpDownBtn(frame: CGRect(x: x, y: 10, width: KMenuBtnWidth, height: bounds.height-10))
            button.setTitle(model.title, for: .normal)
            button.zf_setImage(url: URL(string: model.coverPath))
            addSubview(button)
        }
    }
}








