//
//  ZFPlayerRequest.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/10/31.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFPlayerRequest: NetworkTool {

    
    class func getPlayerData(_ albumId: String, _ trackId: String, _ completion: @escaping NetworkCompletion) {
        let url = kBaseUrl + "v1/track/ca/playpage/" + trackId
        let param = ["albumId" : albumId,
                     "device": "iPhone",
                     "trackUid": trackId]
        request(url: url, method: .GET, parameters: param, completion: completion)
    }
    
    class func getRecommendAlbumList(_ albumId: String, _ completion: @escaping ([AlbumInfoModel]) -> ()) {
        let url = kAlbumUrl + "rec-association/recommend/album/by_album"
        let param = ["albumId" : albumId,
                     "device" : "iPhone"]
        request(url: url, method: .GET, parameters: param) { (resultDict, error) in
            guard let resultDict = resultDict else {completion([AlbumInfoModel]())
                return}
            let albumInfoMs = AlbumInfoModel.mj_objectArray(withKeyValuesArray: resultDict["albums"]) as! [AlbumInfoModel]
            completion(albumInfoMs)
            
        }
    }
    class func getCommentList(_ trackId: String, _ completion: @escaping ([CommentInfoModel]) -> ()) {
        let url = kBaseUrl + "mobile/track/comment"
        let param = ["trackId" : trackId,
                     "device" : "iPhone",
                     "pageId" : "1",
                     "pageSize" : "66"]
        request(url: url, method: .GET, parameters: param) { (resultDict, error) in
            guard let resultDict = resultDict else { completion([CommentInfoModel]())
                return}
            let commentMs = CommentInfoModel.mj_objectArray(withKeyValuesArray: resultDict["list"]) as! [CommentInfoModel]
            completion(commentMs)
            
        }
        
    }
    
}
