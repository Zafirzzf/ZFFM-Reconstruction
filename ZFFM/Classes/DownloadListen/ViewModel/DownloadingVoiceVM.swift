//
//  DownloadingVoiceVM.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class DownloadingVoiceVM {
    static func updateCell(_ model: DownloadVoiceModel, _ cell: DownloadVoiceCell) {
        cell.filesizeLabel.text = String(describing: model.fileFormateSize)
        cell.downloadProgressV.progress = Float(model.downloadProgress)
//        print(model.downloadProgress)
        cell.downloadProgressLabel.text = String(describing: model.downLoadFromateSize) + "/" + model.fileFormateSize
        cell.progressBackView.isHidden = model.isDownLoaded
        cell.playOrPauseBtn.kf.setBackgroundImage(with: URL(string: model.coverSmall), for: .normal)
        
    }
    static func setModelToCell(_ model: DownloadVoiceModel, _ cell: DownloadVoiceCell) {
        cell.playOrPauseBtn.kf.setBackgroundImage(with: URL(string: model.coverSmall), for: .normal)
        cell.voiceTitleLabel.text = model.title
        cell.voiceAuthorLabel.text = "by" + model.nickname
        cell.playCountBtn.setTitle(model.playsCounts, for: .normal)
        cell.commentBtn.setTitle(model.commentsCounts, for: .normal)
        cell.durationBtn.setTitle(model.duration, for: .normal)
        
        cell.filesizeLabel.text = String(describing: model.fileFormateSize)
        cell.downloadProgressV.progress = Float(model.downloadProgress)
        cell.downloadProgressLabel.text = String(describing: model.downLoadFromateSize) + "/" + model.fileFormateSize
        cell.progressBackView.isHidden = model.isDownLoaded
        
        
        if model.isDownLoaded {
            
        }else {
            cell.playURL = URL(string: model.playPathAacv164)
            cell.downloadOrPauseBtn.isSelected = model.isDownLoading
        }

        let downloadUrl = URL(string: model.playPathAacv164)!
        let downloader = ZFDownloadManager.shareInstance.downloaderInListArr(downloadUrl)

        // 暂停播放状态改变
     
        // 点击删除
        cell.deleteClick = {
            // 清除本地文件
            if model.isDownLoading {
                downloader.cancelAndClean()
            }
            DownloadDataTool.deleteDownloadedVoice(model)
        }
        // 开始/暂停下载
        cell.downloadOrPauseClick = {
            DownloadDataTool.pauseOrStartDownload(model)
        }
        // 点击播放
        cell.playOrPauseClick = {
            
        }
      
        
    }
  
}
// 时
extension DownloadingVoiceVM {
    
}
