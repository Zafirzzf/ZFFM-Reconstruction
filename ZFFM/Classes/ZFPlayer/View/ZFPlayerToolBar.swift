//
//  ZFPlayerToolBar.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/23.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

/// 解决播放进度条超出父试图范围不响应的问题所新建的类
class ZFPlayerToolBar: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            var view = super.hitTest(point, with: event)
            if view == nil {
                
                for subview in subviews {
                    let tp = subview.convert(point, from: self)
                    guard let tpView = subview.hitTest(tp, with: event) else { continue}
                    view = tpView
                }
            }

            return view
        }
    }


