//
//  DownloadAlbumModel.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/21.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import RealmSwift
class DownloadAlbumModel: Object {
    var voiceMs = List<DownloadVoiceModel>()

    @objc dynamic var nickname = ""
    @objc dynamic var albumId = ""
    @objc dynamic var coverSmall = ""
    @objc dynamic var albumTitle = ""
//    
    @objc convenience init(nickname: String, albumId: String, coverSmall: String, albumTitle: String) {
        self.init()
        self.nickname = nickname
        self.albumId = albumId
        self.coverSmall = coverSmall
        self.albumTitle = albumTitle
    }
//

    

    
    @objc var fileFormatSize: String {
        var downloadSize: Float = 0
        for voiceM in voiceMs {
            downloadSize += voiceM.downloadSize
        }
        let size = ZFFileTool.caculateFileSizeInUnit(downloadSize)
        let unit = ZFFileTool.caculateUnit(downloadSize)
        return String(format: "%.1f %@", size,unit)
        
    }
}
