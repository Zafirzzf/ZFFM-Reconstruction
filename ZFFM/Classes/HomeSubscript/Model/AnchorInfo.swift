//
//  AnchorInfo.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AnchorInfo: NSObject {
    @objc var uid = ""
    @objc var nickname = ""
    @objc var isVerified = false
    @objc var smallLogo = ""
    @objc var isFollowed = false
    @objc var followers = ""
    @objc var followings = ""
    @objc var tracks = ""
    @objc var albums = ""
    
    @objc var ptitle = ""
    @objc var personDescribe = ""
    @objc var personalSignature = ""
    @objc var anchorCellHeight: CGFloat  {
        var height: CGFloat
        let textH = (self.personalSignature as NSString).boundingRect(with: CGSize(width: KSCREEN_W - 30, height: 10000), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)], context: nil).height
        height = textH + 142
        return height
    }
    override var description: String {
        return yy_modelDescription()
    }
}
