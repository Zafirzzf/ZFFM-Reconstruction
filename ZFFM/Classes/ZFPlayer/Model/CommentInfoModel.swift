//
//  PlayerCommentInfoModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class CommentInfoModel: NSObject {
        var id = ""
        var track_id = ""
        var uid = ""
        var nickname = ""
        var smallHeader = ""
        var content = ""
        var createdAt = ""
        var updatedAt = ""
        var parentId = ""
        var likes = ""
    var oneCommentHeight: CGFloat = 60
    var contentHeight: CGFloat {
        let contentW = KSCREEN_W - 75
        return  38 + (content as NSString).boundingRect(with: CGSize(width: contentW, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], context: nil).size.height
    }
    override var description: String {
        return yy_modelDescription()
    }
    
}
