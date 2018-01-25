//
//  UIImageView+Extension.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
extension UIImageView {
    @objc convenience public init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        self.image = image
    }
}
