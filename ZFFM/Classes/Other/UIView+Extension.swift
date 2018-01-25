//
//  UIView+Extension.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/20.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
extension UIView {
   @objc open var zf_width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
   @objc open var zf_height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }

}
