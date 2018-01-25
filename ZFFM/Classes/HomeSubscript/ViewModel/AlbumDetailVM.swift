//
//  AlbumDetailVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumDetailVM: NSObject {
    
    @objc var albumMenu = AlbumMenu()
    @objc var albumDetail = AlbumDetail()
    @objc var menuListArr = [TrackInfo]()
    @objc func getAlbumMenu(_ albumId: String, _ isSuccess: @escaping (_ success: Bool) -> ()) {
        AlbumRequest.getAlbumMenu(albumId) { (resultDict, error) in
            guard let resultDict = resultDict else { isSuccess(false); return}
            self.albumMenu = AlbumMenu.mj_object(withKeyValues: resultDict["data"])
            self.menuListArr = self.albumMenu.tracks.list

            isSuccess(true)
        }
    }
    
    @objc func getAlbumDetail(_ albumId: String, _ isSuccess: @escaping (_ success: Bool) -> ()) {
        AlbumRequest.getAlbumDetail(albumId) { (resultDict, error) in
            guard let resultDict = resultDict else { isSuccess(false); return}
            self.albumDetail = AlbumDetail.mj_object(withKeyValues: resultDict["data"])
            isSuccess(true)
        }
    }
    @objc func getAlbumTrackList(_ albumId: String, _ isSuccess: @escaping (_ success: Bool) -> ()) {
        AlbumRequest.getAlbumTrackList(albumId) { (resultDict, error) in
            guard let resultDict = resultDict else { isSuccess(false); return}
            let tracks = Tracks.mj_object(withKeyValues: resultDict["data"])
            self.menuListArr = tracks?.list ?? []
            isSuccess(true)
        }
    }
}
