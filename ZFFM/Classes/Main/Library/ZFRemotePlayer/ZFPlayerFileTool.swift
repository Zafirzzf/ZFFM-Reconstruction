//
//  ZFPlayerFileTool.swift
//  ZFRemotePlayer(播放器)
//
//  Created by 周正飞 on 2017/10/16.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import MobileCoreServices
class ZFPlayerFileTool {

    /// 获取缓存路径
    ///
    /// - Parameter url: url
    /// - Returns: 路径
    static func cacheFilePath(url: URL) -> String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/" + url.lastPathComponent
    }
    // 临时保存路径
    static func tempFilePath(url: URL) -> String {
        return NSTemporaryDirectory() + url.lastPathComponent
    }
    
    /// 是否缓存过url资源
    ///
    /// - Parameter url: url
    /// - Returns: 是否缓存过
    static func cacheFileExist(url: URL) -> Bool {
//        wKgJoFo2S1Oi_AABAJtRGUCIWao604.m4a
//        http://download.xmcdn.com/group36/M05/DF/CA/wKgJUlo2TvnzVlDYAEy8z-yyhjg950.aac
        return FileManager.default.fileExists(atPath: cacheFilePath(url: url))
    }
    static func tempFileExist(url: URL) -> Bool {
        return FileManager.default.fileExists(atPath: tempFilePath(url: url))
    }
    
    static func cacheFileSize(url: URL) -> Int {
        guard cacheFileExist(url: url) else {return 0}
        let cachePath = cacheFilePath(url: url)
        let fileInfo = try? FileManager.default.attributesOfItem(atPath: cachePath)
        guard let info = fileInfo else {return 0}
        let size = info[FileAttributeKey.size]
        return size as! Int
    }
    static func tempFileSize(url: URL) -> Int {
        guard tempFileExist(url: url) else {return 0}
        let tempPath = tempFilePath(url: url)
        let fileInfo = try? FileManager.default.attributesOfItem(atPath: tempPath)
        guard let info = fileInfo else {return 0}
        let size = info[FileAttributeKey.size]
        return size as! Int
    }
    static func moveTempPathToCache(_ url: URL) {
        let path = tempFilePath(url: url)
        try?FileManager.default.moveItem(atPath: path, toPath: cacheFilePath(url: url))
    }
    static func clearTempFile(_ url: URL) {
        let path = tempFilePath(url: url)
        try? FileManager.default.removeItem(atPath: path)
    }
    
    static func contentType(url: URL) -> String {
        let path = cacheFilePath(url: url) as NSString
        let fileExtension = path.pathExtension
        let contentTypeCF = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, fileExtension as CFString, nil)
        return CFBridgingRetain(contentTypeCF) as? String ?? "mp3"

        
    }
}
