//
//  NaviTitleView.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/7.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class NaviTitleView: UIView {

    @objc var title = ""
    @objc var titleLabel = UILabel()
    @objc init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.title = title
        setupUI()
    }

    fileprivate func setupUI() {
        isUserInteractionEnabled = false
        titleLabel.text = title
        titleLabel.textColor = KSubjectColor
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        let frame = CGRect(x: 0, y: bounds.height - 30, width: bounds.width, height: 21)
        titleLabel.frame = frame
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
  

        
    }
//    override var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set {
//            super.center = CGPoint(x: superview?.center.x ?? 0, y: (superview?.zf_height ?? 0 ) / 2)
//        }
//    }
    override func layoutSubviews() {
        super.layoutSubviews()
       
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


