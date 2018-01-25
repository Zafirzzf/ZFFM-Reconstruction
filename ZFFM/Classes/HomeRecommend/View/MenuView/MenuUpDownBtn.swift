//
//  MenuUpDownBtn.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MenuUpDownBtn: UIButton {
    
    @objc let radio:CGFloat = 0.7
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initlaize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK:- UI配置
extension MenuUpDownBtn {
    @objc func initlaize() {
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        setTitleColor(UIColor.black, for: .normal)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: contentRect.height * radio, width: contentRect.width, height: contentRect.height * (1 - radio))
    }
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: contentRect.width, height: contentRect.height * radio)
    }
}
