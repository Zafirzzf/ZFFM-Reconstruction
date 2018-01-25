//
//  PlayerCommentGroupModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerCommentGroupModel: NSObject {
    @objc var groupTitle =  ""
    @objc var groupDetailTitle = ""
    @objc var commentInfoMs = [CommentInfoModel]()
    @objc var trackId = ""
    
    @objc init(title: String, subTitle: String, trackId: String, commentInfoMs: [CommentInfoModel]) {
        self.groupTitle = title
        self.groupDetailTitle = subTitle
        self.trackId = trackId
        self.commentInfoMs = commentInfoMs
    }
    
    
    @objc var totalCellheight: CGFloat {
        var middleCellHeight: CGFloat = 0

        for comment in commentInfoMs {
            middleCellHeight = comment.oneCommentHeight + middleCellHeight
        }

        return 30 * 2  + middleCellHeight
    }
    
}
