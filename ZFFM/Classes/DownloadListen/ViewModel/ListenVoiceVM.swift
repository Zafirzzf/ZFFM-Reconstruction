//
//  ListenVoiceVM.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ListenVoiceVM {
     var voiceMs: [DownloadVoiceModel] = []
    
    func loadData(_ key: String, _ pageNum: Int, finished:@escaping () -> ()) {
        
        
    }
    
     func setModelToCell(index: Int, cell: ListenTodayVoiceCell) {
        
        let model = voiceMs[index]
        cell.sortNumLabel.text = String(model.sortNum)
        switch model.sortNum {
        case 1:
            cell.sortNumLabel.textColor = .red
        case 2:
            cell.sortNumLabel.textColor = .magenta
        case 3:
            cell.sortNumLabel.textColor = .green
        default:
            cell.sortNumLabel.textColor = .gray
        }
        
        cell.voiceTitleLabel.text = model.title
        cell.voiceAuthorLabel.text = "by" + model.nickname
        cell.playOrPauseBtn.zf_setImage(url: URL(string: model.coverSmall))
        // 设置下载的图标
        let state = DownloadDataTool.getVoiceDownloadState(model)
        cell.downloadBtn.isEnabled = state == .wait

        switch state {
        case .downloading:
            self.addAnimateToButton(cell.downloadBtn)
        case .wait:
            cell.downloadBtn.imageView?.layer.removeAllAnimations()
            cell.downloadBtn.setImage(UIImage(named: "cell_download"), for: .normal)
        case .downloaded:
            cell.downloadBtn.imageView?.layer.removeAllAnimations()
            cell.downloadBtn.setImage(UIImage(named: "cell_downloaded"), for: .normal)

        }
        
        // 点击下载
        cell.downloadBlock = {
            self.addAnimateToButton(cell.downloadBtn)
            DownloadDataTool.startDownload(model)
        }

    }
     func addAnimateToButton(_ button: UIButton) {
        button.setImage(UIImage(named: "cell_download_loading"), for: .normal)
        let transAni = CABasicAnimation(keyPath: "transform.rotation.z")
        transAni.fromValue = 0
        transAni.toValue = Double.pi * 2
        transAni.duration = 3
        transAni.repeatCount = MAXFLOAT
        button.imageView?.layer.add(transAni, forKey: nil)
    }
}
