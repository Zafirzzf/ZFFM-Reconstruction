//
//  ZFDownloadManager.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/7.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFDownloadManager: NSObject {

    @objc static let shareInstance = ZFDownloadManager()
    @objc var downloadList: [[URL: ZFDownloader]] = []
    private override init() {
        super.init()
    }
    
    // 下载或暂停
    func startDownload(_ url: URL, _ downloadTotalSize: DownloadInfo? = nil, _ stateChange: StateChangeBlock? = nil, _ progress: ProgressChangeBlock? = nil, _ successFilepath: SuccessBlock? = nil, _ failedError: FailedBlock? = nil) {
   
        let downloader = downloaderInListArr(url)
        downloader.download(url, downloadTotalSize, stateChange, progress, { (filePath) in
            self.downloadList.remove(at: self.indexOfDownloaderInList(url))
            successFilepath?(filePath)
        }, failedError)
        
    }
    
    // 全部暂停
    @objc func pauseAll() {
        for dict in downloadList {
            _ = dict.values.map{$0.pauseCurrentTask()}
        }
    }
    // 全部开始
    @objc func resumeAll() {
        for dict in downloadList {
            _ = dict.values.map{$0.resumeCurrentTask()}
        }
 
    }
    @objc func downloaderOfIndex(_ index: Int) -> ZFDownloader? {
        return downloadList[index].values.first
    }
    
    
    @objc func downloaderInListArr(_ urlKey: URL) -> ZFDownloader {
        for dict in downloadList{
            if let downloader = dict[urlKey] {
                return downloader
            }
        }
        let downloader = ZFDownloader()
        downloadList.append([urlKey: downloader])
        return downloader
    }
    fileprivate func indexOfDownloaderInList(_ urlKey: URL) -> Int {
        for (i, dict) in downloadList.enumerated() {
            if dict[urlKey] != nil {
                return i
            }
        }
        return 0
    }

}
