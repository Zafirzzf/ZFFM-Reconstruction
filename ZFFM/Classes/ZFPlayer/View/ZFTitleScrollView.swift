//
//  ZFTitleScrollView.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/2.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFTitleScrollView: UIScrollView {
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    @objc var title: String =  "" {
        didSet {
            setContentTitle()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZFTitleScrollView {
    @objc convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        self.title = title
    }

   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.center.y = bounds.height * 0.5
        titleLabel.frame.origin.x = 0
        if contentSize.width <= bounds.width {
            titleLabel.center.x = bounds.width * 0.5
        }
    }
    
    fileprivate func setContentTitle() {
        titleLabel.layer.removeAnimation(forKey: "translation")
        titleLabel.removeFromSuperview()
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        addSubview(titleLabel)
        contentSize = CGSize(width: titleLabel.bounds.width, height: 0)
        if contentSize.width > bounds.width {
            addScrollAnimate()
        }
    }
    fileprivate func addScrollAnimate() {
        let animation1 = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation1.values = [0,0,-(contentSize.width - bounds.width),-(contentSize.width - bounds.width),0]
        animation1.keyTimes = [0,0.1,0.5,0.6,1]
        animation1.duration = CFTimeInterval(title.characters.count) * 0.8
        animation1.isRemovedOnCompletion = false
        animation1.repeatCount = MAXFLOAT

        titleLabel.layer.add(animation1, forKey: "translation")
    }
    
}



