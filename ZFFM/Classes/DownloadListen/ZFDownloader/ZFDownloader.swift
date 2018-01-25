//
//  ZFDownloader.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/1.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

let KdownloadedPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
let KdownloadingPath = NSTemporaryDirectory()


enum ZFDownloadState: Int {
    case pause
    case downloading
    case success
    case failed
}
typealias DownloadInfo = (_ totalsize: CGFloat) -> ()
typealias ProgressChangeBlock = (_ progress: CGFloat) -> ()
typealias StateChangeBlock = (_ state: ZFDownloadState) -> ()
typealias SuccessBlock = (_ filepath: String) -> ()
typealias FailedBlock = (_ error: Error) -> ()
class ZFDownloader: NSObject {
    
    // 外界注册的闭包
    @objc var downloadInfo: DownloadInfo?
    var stateChange: StateChangeBlock?
    @objc var progressChange: ProgressChangeBlock?
    @objc var successDownload: SuccessBlock?
    @objc var faildDownload: FailedBlock?
    // 请求用的URLSession
    fileprivate lazy var session: URLSession = {
        URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
    }()
    // 请求用的Task
    fileprivate lazy var dataTask: URLSessionDataTask = {
        self.session.dataTask(with: URL(string: "https://www.baidu.com")!) // 为了让datatask.orginalrequest不为空,默认给一个
    }()
    // 保存数据的输出流
    fileprivate lazy var outputStream: OutputStream = OutputStream()

    
    //当前下载状态
    fileprivate(set) var state: ZFDownloadState = .pause {
        didSet {
            stateChange?(state)
            if state == .success {
                successDownload?(downloadedPath)
            }

        }
    }
    @objc fileprivate(set) var progress: CGFloat = 0 {
        didSet {
            progressChange?(progress)

        }
    }
    
    
    // 下载的起始大小
    fileprivate var tempSize: Int = 0
    // 下载的文件总大小
    fileprivate var totalSize: Int = 0
    fileprivate var downloadingPath = ""
    fileprivate var downloadedPath = ""
    
    
    func download(_ url: URL, _ downloadTotalSize: DownloadInfo? = nil, _ stateChange: StateChangeBlock? = nil, _ progress: ProgressChangeBlock? = nil, _ successFilepath: SuccessBlock? = nil, _ failedError: FailedBlock? = nil) {
        
        self.downloadInfo = downloadTotalSize
        self.stateChange = stateChange
        self.progressChange = progress
        self.successDownload = successFilepath
        self.faildDownload = failedError
        
        // 当前任务已经添加
        if url == dataTask.originalRequest?.url {
            // 如果是暂停 继续
            switch state {
            case .pause:
                resumeCurrentTask()
                return
            case .downloading:
                pauseCurrentTask()
                return
            default:
                break
            }
        }
        
        
        // 文件的存放
        // 下载中的 ==> temp + 名称
        // 下载完成 ==> cache + 名称
        
        let filename = url.lastPathComponent
        downloadedPath = KdownloadedPath + "/" + filename
        
        downloadingPath = KdownloadingPath + "/" + filename
        //Mark-- warning
        // 1. 判断 url地址,是下载完毕.
        // 1.1 通知外界 下载完毕, 传递 文件路径/文件大小 的信息
        if  ZFFileTool.fileIsExist(downloadedPath) {
            // 告诉外界文件已经下载过 待补充
            state = .success
            return
        }
        // 2. 检测本地temp里是否有 文件路径.
        
        // 2.1 如果没有  从0开始下载
        if !ZFFileTool.fileIsExist(downloadingPath) {
            downloadUrl(url, offSet: 0)
        }else {
            // 2.2 如果有  获取当前文件大小, 从此大小的字节开始往后下载 HTTP: Range
            tempSize = ZFFileTool.fileSize(downloadingPath) // 获取本地大小
            
            downloadUrl(url, offSet: tempSize)
            
        }
    }
    @objc func pasueOrStart() {
        if state == .downloading {
            dataTask.suspend()
            state = .pause
        }else if state == .pause || state == .failed {
            dataTask.resume()
            state = .downloading
        }
       
    }
  
}
//MARK:- 状态控制方法
extension ZFDownloader {
    // 暂停下载
    @objc func pauseCurrentTask() {
        if state == .downloading {
            dataTask.suspend()
            state = .pause
        }
    }
    // 取消下载
    @objc func cancelCurrentTask() {
        dataTask.cancel()
        state = .failed
    }
    // 取消并且清除本地记录
    @objc func cancelAndClean() {
        cancelCurrentTask()
        ZFFileTool.removeFile(downloadingPath)
    }
    // 继续下载
    @objc func resumeCurrentTask() {
        if state == .pause || state == .failed {
            dataTask.resume()
            state = .downloading
        }

    }
}

extension ZFDownloader {
    
     fileprivate func downloadUrl(_ url: URL, offSet: Int) {
      
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 0)
        // 从offset 下载到最后
        // content-Length为将要下载的字节数. content_range为起始字节到总字节数
        // ** 注意 设置httpheader时候bytes后面如果是带小数的,会存在content-length只为offset的情况
        
        request.setValue("bytes=\(offSet)-", forHTTPHeaderField: "Range")
        // 创建一个session 分配一个dataTask任务, 默认情况属于挂起状态
        dataTask = session.dataTask(with: request)
        resumeCurrentTask()
        
    }
}
//MARK:- session下载的协议
extension ZFDownloader: URLSessionDataDelegate {
    // 第一次接受到响应的时候调用(响应头, 并没有请求到具体的资源内容)
    // 通过判断response 可以设置comletionHandler是继续请求还是取消
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        // Content-Length  是要请求的大小(设置range之后的).  并不是下载的文件总大小.
        // Content-Range 必须要在request中设置range请求头,而且有要下载的内容时才会有值
        var contentLength = ((response as! HTTPURLResponse).allHeaderFields["Content-Length"] as! String).transformToInt()
        if contentLength == 0 { // 所需下载的长度为0,, 文件变更,重新下载
            // 1. 删除临时缓存
            ZFFileTool.removeFile(downloadedPath)
            // 2. 从0 开始重新下载
            downloadUrl(response.url!, offSet: 0)
            completionHandler(.cancel)
        }else {
            if let rangeTotalSize = (response as! HTTPURLResponse).allHeaderFields["Content-Range"] as? NSString {
                contentLength = rangeTotalSize.lastPathComponent.transformToInt()
            }
            // 用闭包传递给外界
            downloadInfo?(CGFloat(contentLength))
            totalSize = contentLength
            state = .downloading
            if tempSize < contentLength {
                // 每次outputStream close之后都要重新创建一个
                outputStream = OutputStream(toFileAtPath: self.downloadingPath, append: true)!
                outputStream.open()
                completionHandler(.allow)
             
            }
        }
    }
    // 当用户确定, 继续接受数据的时候调用
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        tempSize += data.count
        progress = CGFloat(tempSize) * 1.0 / (CGFloat(totalSize) *  1.0)
        
        let byes = data.withUnsafeBytes { (byes) -> UnsafePointer<UInt8> in
            return byes
        }
        outputStream.write(byes, maxLength: data.count)
    }
    
    // 请求完成时调用 成功/失败
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil { // 不一定成功
            // 判断, 1. 本地缓存 == 文件总大小
            // 2. 验证文件是否完整(file md5)

            // 3. 移动
            ZFFileTool.moveFile(downloadingPath, path: downloadedPath)
            state = .success
            print("下载成功")
        }else {
         
            if  (error! as NSError).code == -999{ // 手动取消
                state = .failed
            }else {
                state = .failed
                print(error!)
            }
            faildDownload?(error!)

        }
        outputStream.close()
    }
}

//MARK:- 事件

extension String {
    func transformToInt() -> Int {
        return Int(self)!
    }

}




