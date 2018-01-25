//
//  ZFTabBar.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFTabBar: UITabBar {
    fileprivate lazy var middleView: ZFTabBarMiddleView = ZFTabBarMiddleView.shareInstance
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImage = UIImage(named: "tabbar_bg")
        addSubview(middleView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let itemW = zf_width / 5.0
        let itemH = zf_height - 8
        let itemY: CGFloat = 8
        var itemX: CGFloat = 0
        _ = subviews.map { (subView) -> UIView in
            guard subView.isKind(of: NSClassFromString("UITabBarButton")!) else {
                return subView
            }
            subView.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            itemX += itemW
            return subView
        }

        middleView.frame.origin = CGPoint(x: center.x - middleView.zf_width / 2, y: zf_height - middleView.zf_height)
        
        // 取消中间占位的点击事件
        for item in items! {
            if item.selectedImage == nil {
                item.isEnabled = false
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK:- 设置中间按钮响应区域
extension ZFTabBar {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointInMiddleBtn = self.convert(point, to: middleView)
        let middleBtnCenter = CGPoint(x: 33, y: 33)
        let distance = sqrt(pow(pointInMiddleBtn.x - middleBtnCenter.x,2 ) + pow(pointInMiddleBtn.y - middleBtnCenter.y, 2))
        if pointInMiddleBtn.y < 3.5 || (distance > 33 && pointInMiddleBtn.y < 18) {
            return false
        }
        return true
     
    }
}
