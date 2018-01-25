//
//  UIButton+Extension.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import Kingfisher
extension UIButton {
    @objc func zf_setImage(url: URL?, placeholder: UIImage? = nil) {
        kf.setImage(with: url, for: .normal, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
    }

}
