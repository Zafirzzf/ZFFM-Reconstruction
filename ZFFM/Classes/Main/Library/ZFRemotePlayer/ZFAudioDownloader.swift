//
//  ZFAudioDownloader.swift
//  ZFRemotePlayer(播放器)
//
//  Created by 周正飞 on 2017/10/17.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
// 下载某一个区间的数据
class ZFAudioDownloader:NSObject, URLSessionDataDelegate {
    
    // 下载数据的session
    fileprivate lazy var session: URLSession = {
       URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
    }() // 用lazy修饰的懒加载,后面block只会走一次.跟OC不同
    
    fileprivate var dataTask: URLSessionTask?
    // 保存数据的输出流
    fileprivate lazy var outputStream: OutputStream = OutputStream()
    fileprivate var url: URL?
    
    var totalSize = 0
    var offSet = 0
    var loadedSize = 0 // 当前资源下载了的长度
    var isCompletePlay = true
    var downloadingBlock: (() -> ())?
    
    
    
    func download(_ url: URL, _ offSet: Int = 0) {
        self.url = url
        cancelAndClean(url)
        self.offSet = offSet
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 0)
        request.setValue("bytes=\(offSet)-", forHTTPHeaderField: "Range")
        
        session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request)
        
        task.resume()
        self.dataTask = task

    }
    func cancelDownload() {
        guard url != nil else {return}
        dataTask?.cancel()
        session.invalidateAndCancel()

    }
    
    func cancelAndClean(_ url: URL) {
        session.invalidateAndCancel()
        dataTask?.cancel() // 不进行cancel的话会继续下载,造成不必要的错误.
        // 清除本地的临时缓存
        loadedSize = 0
        ZFPlayerFileTool.clearTempFile(url)
    }

}

//MARK:- session的代理
extension ZFAudioDownloader {
    // 第一次接收到响应投的时候  response
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        outputStream = OutputStream(toFileAtPath: ZFPlayerFileTool.tempFilePath(url: response.url!), append: true)!
        outputStream.open()
        completionHandler(.allow)
        
        // 获取文件总大小
        var headerInfo = (response as! HTTPURLResponse).allHeaderFields
        totalSize = Int(headerInfo["Content-Length"] as! String)!
        if let rangeTotalSize = headerInfo["Content-Rnage"] as? NSString {
            totalSize = Int(rangeTotalSize.lastPathComponent)!
        }
        
        
    }
    // 接收数据的过程当中
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        loadedSize += data.count
        let byes = data.withUnsafeBytes { (byes) -> UnsafePointer<UInt8> in
            return byes
        }
    
        outputStream.write(byes, maxLength: data.count)
        print("下载中")
        downloadingBlock?()
    }
    // 请求完成时 成功/失败
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil {
            // 成功
            guard isCompletePlay else {return}
            guard let url =  task.response?.url else { return }
            if totalSize == ZFPlayerFileTool.tempFileSize(url: url) {
                ZFPlayerFileTool.moveTempPathToCache(url)
            }
        }else {
            print("下载出错")
        }
    }
}

