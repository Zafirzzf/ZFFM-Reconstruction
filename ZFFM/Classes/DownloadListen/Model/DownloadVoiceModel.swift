//
//  ListenVoiceModel.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import RealmSwift
class DownloadVoiceModel: Object {
    @objc dynamic var albumId = "" // 专辑ID
    @objc dynamic var albumTitle = "" // 专辑名称
    @objc dynamic var commentsCounts = "" // 评论个数
    
    // 声音类信息
    @objc dynamic var trackId = ""
    @objc dynamic var title = ""
    @objc dynamic var playPathAacv164  = "" // 播放URL
    @objc dynamic var duration = "" // 播放时长
    @objc dynamic var playsCounts = "" // 播放次数
    @objc dynamic var nickname = ""
    @objc dynamic var coverSmall = "" // 覆盖图片
    @objc dynamic var favoritesCounts = ""
    
    // 下载相关信息
    @objc dynamic var downloadSize: Float = 0
    @objc dynamic var downloadUrl = ""

    // 请求相关信息
    @objc dynamic var uid = ""
    @objc var sortNum = 0
    
    // 附加信息
    @objc dynamic var isDownLoaded = false
    
    @objc dynamic var downloadProgress: Float {
        print(ZFFileTool.downloadingFileSize(downloadUrl))
        return ZFFileTool.downloadingFileSize(downloadUrl) / downloadSize
    }
    // 是否正在下载
    @objc dynamic var isDownLoading: Bool {
        let downloader = ZFDownloadManager.shareInstance.downloaderInListArr(URL(string: downloadUrl)!)
        return downloader.state == .downloading
    }
    
    // 格式化后文件总大小
    @objc dynamic var fileFormateSize: String {
        let size = ZFFileTool.caculateFileSizeInUnit(downloadSize)
        let unit = ZFFileTool.caculateUnit(downloadSize)
        return String(format: "%.1f %@", size,unit)
    }
    
    //格式化后文件已下载大小
    @objc dynamic var downLoadFromateSize: String {
        let downloadingSize = ZFFileTool.downloadingFileSize(downloadUrl)
        let size = ZFFileTool.caculateFileSizeInUnit(downloadingSize)
        let unit = ZFFileTool.caculateUnit(downloadingSize)
        return String(format: "%.1f %@", size,unit)
    }
    
    override var description: String {
        return yy_modelDescription()
    }
}
