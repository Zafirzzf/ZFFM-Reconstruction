//
//  UIButton+Fast.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
extension UIButton {
    @objc convenience init(title: String? = nil, normalTitleColor: UIColor? = nil, highlightTitleColor: UIColor? = nil, normalImage: UIImage? = nil, highlightImage: UIImage? = nil) {
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        setTitleColor(normalTitleColor, for: .normal)
        if highlightTitleColor != nil {
            setTitleColor(highlightTitleColor, for: .highlighted)
        }
        setImage(normalImage, for: .normal)
        if highlightImage != nil {
            setImage(highlightImage, for: .highlighted)
        }
        sizeToFit()
    }
    
    
}
