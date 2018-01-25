//
//  ZFPlayerVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFPlayerVM {
    
//    var trackInfoM: TrackInfoModel?
//    var albumInfoM: AlbumInfoModel?
//    var groupM: PlayerGroupModel?
//    var userInfoM: PlayerUserInfoModel?
//    var commentGroupM: PlayerCommentGroupModel?
//    var rewardInfoM: TrackRewardModel?
    var playerPanVM: ZFPlayerPaneVM?
    var title = ""
    var albumInfoVM: ZFPlayerAlbumVM?
    var recommendGroupM: PlayerGroupModel?
    var commentGroupM: PlayerCommentGroupModel?
    var rewardInfoM = TrackRewardModel()
    func getPlayerData(_ albumId : String, _ trackId: String, _ completion:@escaping () -> ()) {
        ZFPlayerRequest.getPlayerData(albumId, trackId) { (resultDict, error) in
            guard let resultDict = resultDict else {return}
            let albumM = AlbumInfoModel.mj_object(withKeyValues: resultDict["albumInfo"])!
            let trackInfoModel = TrackInfoModel.mj_object(withKeyValues: resultDict["trackInfo"])!
            trackInfoModel.albumId = albumId
            self.title = trackInfoModel.title
            self.albumInfoVM = ZFPlayerAlbumVM(albumM)
            
            let associationAlbumMs = AlbumInfoModel.mj_objectArray(withKeyValuesArray: resultDict["associationAlbumsInfo"]) as! [AlbumInfoModel]
            let groupM = PlayerGroupModel(title: "相关推荐",
                                          subTitle: "查看更多推荐 >",
                                          albumId: albumId,
                                          albumInfoMs: associationAlbumMs)

            self.recommendGroupM = groupM
            let userInfoM = PlayerUserInfoModel.mj_object(withKeyValues: resultDict["userInfo"])!
            let commentInfoMs = CommentInfoModel.mj_objectArray(withKeyValuesArray: resultDict["commentInfo"]!["list"]) as! [CommentInfoModel]
            self.playerPanVM = ZFPlayerPaneVM(trackModel: trackInfoModel, userinfoModel: userInfoM)
            
            let commentGroupM = PlayerCommentGroupModel(title: "听众点评",
                                                        subTitle: "查看更多评论",
                                                        trackId: trackId,
                                                        commentInfoMs: commentInfoMs)

            self.commentGroupM = commentGroupM
            let rewardInfoM = TrackRewardModel.mj_object(withKeyValues: resultDict["trackRewardInfo"])!
            rewardInfoM.voiceIntro = trackInfoModel.trackId
            rewardInfoM.voiceIntro = trackInfoModel.shortRichIntro
            self.rewardInfoM = rewardInfoM
            completion()
            
        }
    }
}
