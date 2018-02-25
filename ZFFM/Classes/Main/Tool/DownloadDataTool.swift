//
//  DownloadDataTool.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import RealmSwift


class DownloadDataTool {
    
    // 获取下载列表
    static func getCurrentDownloadingVoices() -> [DownloadVoiceModel] {
        
        let realm = try!Realm()
        let voices = realm.objects(DownloadVoiceModel.self)
        var models = [DownloadVoiceModel]()
        for voice in voices {
            if !voice.isDownLoaded {
                 models.append(voice)
            }
        }
        return models
    }
    
    // 获取下载的声音列表
    static func getDownloadedVoices() -> [DownloadVoiceModel] {
        let realm = try!Realm()
        let voices = realm.objects(DownloadVoiceModel.self).filter("isDownLoaded == 1")
        return voices.map{ $0 }
    }
    
    // 获取下载的专辑列表
    static func getCurrentDownloadAlbum() ->[DownloadAlbumModel] {
        let realm = try!Realm()
        let voices = realm.objects(DownloadVoiceModel.self)
        var albumModels = [DownloadAlbumModel]()
        for voice in voices {
            // 找出已经下载好的,不重复albumId的专辑
            if voice.isDownLoaded && (!albumModels.map{$0.albumId}.contains(voice.albumId)){
                let album = DownloadAlbumModel(nickname: voice.nickname, albumId: voice.albumId, coverSmall: voice.coverSmall, albumTitle: voice.albumTitle)
                albumModels.append(album)
            }
        }
        for album in albumModels {
           let voicesInAlbum = realm.objects(DownloadVoiceModel.self).filter("albumId == '\(album.albumId)'")
             album.voiceMs = List(voicesInAlbum)
        }
        
        return albumModels
    }
//    static func getDownloadedVoiceListInAlbum(_ album: DownloadAlbumModel) -> [DownloadVoiceModel] {
//        let realm = try!Realm()
//        let voices = realm.objects(DownloadVoiceModel.self).filter("isDownLoaded == 1")
//        return voices.map{ $0 }
//        album.albumId
//    }
    // 开始下载某一任务
    static func startDownload(_ model: DownloadVoiceModel) {
        // 判断任务是否已下载
        guard  !voiceUrlIsDownloaded(model) else {return}
        DownloadListenRequest.setDownloadMessageToVoiceM(model) {//获取了下载信息
            
            // 1. 将下载信息缓存到数据库
            DownloadDataTool.addDownloadVoiceModel(model)
         
            // 2. 开启下载任务
            guard let downloadUrl = URL(string: model.downloadUrl) else {
                print("下载链接出现错误");return
            }
            startOrPause(downloadUrl)

        }
    }
    // 暂停或继续
    static func pauseOrStartDownload(_ model: DownloadVoiceModel) {
        startOrPause(URL(string: model.downloadUrl)!)
    }
    
    // 数据库添加下载任务
    static func addDownloadVoiceModel(_ model: DownloadVoiceModel) {
        let realm = try!Realm()
        try!realm.write {
            realm.add(model)
        }
    }
    // downloadManager添加下载任务.
    static func startOrPause(_ url: URL) {
        ZFDownloadManager.shareInstance.startDownload(url, nil, { (state) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: KDownloadStateChange), object: nil, userInfo: ["state": state])
        }, { (progress) in
//            print(progress)
        }, { (success) in
            setVoiceDownloadedSuccess(url.absoluteString)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: KDownloadListChange),  object: nil)
        }, { (error) in
            
        })
    }
    
    // 某一任务下载完毕
    static func setVoiceDownloadedSuccess(_ downloadUrl: String) {
        let realm = try!Realm()
        try! realm.write({
            let predicateStr = "downloadUrl == " + "'\(downloadUrl)'"
            let downloadModel = realm.objects(DownloadVoiceModel.self).filter(predicateStr).first
            downloadModel?.isDownLoaded = true
        })
    }
    // 某一任务是否已添加到下载列表
    static func voiceUrlIsDownloaded(_ model: DownloadVoiceModel) -> Bool {
        guard let url = URL(string: model.downloadUrl) else {return false}
        let filename = url.lastPathComponent
        let downloadedPath = KdownloadedPath + "/" + filename
        let downloadingPath = KdownloadingPath + "/" + filename
        return ZFFileTool.fileIsExist(downloadedPath) || ZFFileTool.fileIsExist(downloadingPath)
    }
    // 删除某一专辑
    static func deleteDownloadedAlbum(_ albumModel: DownloadAlbumModel) {
        for voice in albumModel.voiceMs {
            deleteDownloadedVoice(voice)
        }

       NotificationCenter.default.post(name: NSNotification.Name(rawValue: KDownloadListChange),  object: nil)
        
    }
    
    // 删除某一声音
    static func deleteDownloadedVoice(_ voice: DownloadVoiceModel) {
        // 1.删除本地音乐
        ZFFileTool.removeFileWithUrl(URL(string: voice.downloadUrl)!)
        // 2.清除数据库中记录
        let realm = try!Realm()
        try!realm.write {
            realm.delete(voice)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: KDownloadListChange),  object: nil)
    }
    
    // 判断某一声音的下载状态
    static func getVoiceDownloadState(_ voice: DownloadVoiceModel) -> VoiceCellDownloadState {
        let realm = try!Realm()
        guard let voice = realm.objects(DownloadVoiceModel.self).filter("trackId == '\(voice.trackId)'").first else {return .wait}
        
        if voice.isDownLoading {
            return .downloading
        } else if voice.isDownLoaded {
            return .downloaded
        } else {
            return .wait
        }
        
    }
    
    
    
}
