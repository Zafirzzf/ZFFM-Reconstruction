//
//  ZFFileTool.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/1.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class ZFFileTool {
    
    class func fileIsExist(_ atPath: String) -> Bool {
        return FileManager.default.fileExists(atPath: atPath, isDirectory: nil)
    }
    
    class func fileSize(_ atPath: String) -> Int {
        let fileinfo = try?FileManager.default.attributesOfItem(atPath: atPath)
        guard let info = fileinfo else {return 0}
        let size = info[FileAttributeKey.size]
        return size as! Int
    
    }
    class func moveFile(_ path: String, path toPath: String) {
        guard fileIsExist(path) else {return}
        try? FileManager.default.moveItem(atPath: path, toPath: toPath)
    }
    class func removeFile(_ filePath: String ){
        guard fileIsExist(filePath) else {return}
        try? FileManager.default.removeItem(atPath: filePath)
    }
    class func removeFileWithUrl(_ url: URL) {
        let filename = url.lastPathComponent
        let downloadedPath = KdownloadedPath + "/" + filename
        removeFile(downloadedPath)
    }
    class func getVoiceLocalUrl(withUrl url: URL) -> String{
        let filename = url.lastPathComponent
        return KdownloadedPath + "/" + filename
    }
    class func downloadingFileSize(_ downloadUrl: String) -> Float {
        let filename = URL(string: downloadUrl)!.lastPathComponent
        let downloadingPath = KdownloadingPath + "/" + filename
        return Float(fileSize(downloadingPath))
    }
    
    static func caculateFileSizeInUnit(_ contentLength: Float) -> Float{
        if contentLength >= pow(1024, 3) {
            return contentLength / powf(1024, 3)
        }else if contentLength >= powf(1024, 2) {
            return contentLength / powf(1024, 2)
        }else if contentLength >= 1024 {
            return contentLength / 1024
        }else {
            return contentLength
        }
    }
    
    static func caculateUnit(_ contentLength: Float) -> String {
        if contentLength >= powf(1024, 3) {
            return "GB"
        }else if contentLength >= powf(1024, 2) {
            return "MB"
        }else if contentLength >= 1024 {
            return "KB"
        }else {
            return "B"
        }
    }
}
