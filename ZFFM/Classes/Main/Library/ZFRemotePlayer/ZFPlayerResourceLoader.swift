//
//  ZFPlayerResourceLoader.swift
//  ZFRemotePlayer(播放器)
//
//  Created by 周正飞 on 2017/10/16.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import AVFoundation

class ZFPlayerResourceLoader: NSObject, AVAssetResourceLoaderDelegate {

    fileprivate lazy var downloader: ZFAudioDownloader = {
        let downloader = ZFAudioDownloader()
        downloader.downloadingBlock = {[weak self] in
           self?.handleAllLoadingRequest()
        }
        return downloader
    }()
    fileprivate var loadingRequests = [AVAssetResourceLoadingRequest]()
    var isSeekProgress = false
    deinit{
        print("loader销毁了")
    }
    
    // 当外界 播放一段音频资源时候,拦截这个方法.根据请求信息,返回给外界数据
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        
        guard let url = loadingRequest.request.url else {return false}
        loadingRequests.append(loadingRequest)

        let requestOffset = Int(loadingRequest.dataRequest!.requestedOffset)
        
        // 1.如果本地有缓存, 根据缓存向外界响应
        if ZFPlayerFileTool.cacheFileExist(url: url) {
            handleLoadingRequest(loadingRequest)
            return true
        }
    
        // 如果没有下载过,请求
        if downloader.loadedSize == 0 {
            downloader.download(url.httpURL(), requestOffset)
            downloader.isCompletePlay = true
            return true
        }
        // 需要重新下载
        // 1. 请求点 < 当前点
        // 2. 请求点 > 当前点 + 已经加载的数据 + 一个范围
        guard !isSeekProgress else {
            if requestOffset < downloader.offSet || requestOffset > downloader.offSet + downloader.loadedSize + 60 {
                downloader.download(url.httpURL(), requestOffset)
                isSeekProgress = false
                downloader.isCompletePlay = false
            }
            return true
        }
        

    
        // 处理资源请求(在下载过程当中,也要不断的判断)
//        handleAllLoadingRequest()
        return true
    }
    
    
    // 取消请求时调用
    func resourceLoader(_ resourceLoader: AVAssetResourceLoader, didCancel loadingRequest: AVAssetResourceLoadingRequest) {
        print("取消某个请求")
        loadingRequests.remove(at: loadingRequests.index(of: loadingRequest)!)
    }

}

//MARK:- 抽取的方法
extension ZFPlayerResourceLoader {
    func handleLoadingRequest(_ loadingRequest: AVAssetResourceLoadingRequest) {

        guard let url = loadingRequest.request.url else {return}
        let totalSize = ZFPlayerFileTool.cacheFileSize(url: url)
        loadingRequest.contentInformationRequest?.contentLength = Int64(totalSize)
        loadingRequest.contentInformationRequest?.contentType = ZFPlayerFileTool.contentType(url: url)

        loadingRequest.contentInformationRequest?.isByteRangeAccessSupported = true // 字节区间支持
        
        // 2. 相应数据给外界
        guard let data = NSData(contentsOfFile: ZFPlayerFileTool.cacheFilePath(url: url)) else {return}
        guard let dateRequest = loadingRequest.dataRequest else {return}
        let requestOffset = dateRequest.requestedOffset
        let requestLength = dateRequest.requestedLength
        let subData = data.subdata(with: NSMakeRange(Int(requestOffset), requestLength))
        loadingRequest.dataRequest?.respond(with: subData)
        loadingRequest.finishLoading()
    }
    
    // 每有数据接受到时候调用
    fileprivate func handleAllLoadingRequest() {
        for loadingRequest in loadingRequests {
            
            guard let url = loadingRequest.request.url else {return}
            let totalSize = downloader.totalSize
            loadingRequest.contentInformationRequest?.contentLength = Int64(totalSize)
            loadingRequest.contentInformationRequest?.contentType = ZFPlayerFileTool.contentType(url: url)
            loadingRequest.contentInformationRequest?.isByteRangeAccessSupported = true
            
            let tempData = NSData(contentsOfFile: ZFPlayerFileTool.tempFilePath(url: url))
            guard let data = tempData != nil ? tempData : try? NSData(contentsOfFile: ZFPlayerFileTool.cacheFilePath(url: url), options: NSData.ReadingOptions.mappedIfSafe) else {return}
         
            let loadedSize = downloader.loadedSize
            guard let dateRequest = loadingRequest.dataRequest else {return}
            var requestOffset = Int(dateRequest.requestedOffset)
            let currentOffset = Int(dateRequest.currentOffset)
            
            if currentOffset != requestOffset {
                requestOffset = currentOffset
            }
            let requestLength = dateRequest.requestedLength
            var responseOffset = requestOffset - downloader.offSet
            let canRedLength = loadedSize + downloader.offSet - requestOffset
            var responseLength = min(requestLength, canRedLength)
            
            if responseLength < 0 {responseLength = 0;}
            if responseOffset < 0 {responseOffset = 0;}
            
            let subData = data.subdata(with: NSMakeRange(responseOffset, min(data.length - 2, responseLength) ))
            loadingRequest.dataRequest?.respond(with: subData)
            if requestOffset + canRedLength >= Int(dateRequest.requestedOffset) + requestLength {
                loadingRequest.finishLoading()
                loadingRequests.remove(at: loadingRequests.index(of: loadingRequest)!)
            }
        }
    }
}



