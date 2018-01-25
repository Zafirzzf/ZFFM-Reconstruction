//
//  PlayerMoreListVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/10.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerMoreListVM: NSObject {

    @objc var recommendModels = [AlbumInfoModel]()
    @objc var commentModels = [CommentInfoModel]()
    
    @objc var albumId: String?
    @objc var trackId: String?
    
    @objc var title = ""
    
    @objc var isCommentList: Bool {
        return trackId != nil
    }
    
    @objc func loadData(_ completion: @escaping () -> ()) {
        if isCommentList { // 评论列表
            ZFPlayerRequest.getCommentList(trackId!, { commentInfoMs in
                self.commentModels = commentInfoMs
                completion()
            })
        }else {
            ZFPlayerRequest.getRecommendAlbumList(albumId!, { (albumInfoMs) in
                self.recommendModels = albumInfoMs
                completion()

            })
        }
    }
    
}
