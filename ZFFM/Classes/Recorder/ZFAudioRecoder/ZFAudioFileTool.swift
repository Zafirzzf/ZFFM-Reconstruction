//
//  ZFAudioFileTool.swift
//  ZFAudioRecoder
//
//  Created by 周正飞 on 2017/11/28.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import AVFoundation
fileprivate let KTempDirectory = NSTemporaryDirectory() + "ZFAudioRecoder"
class ZFAudioFileTool: NSObject {
     var tempRecoderPath: String = {
        if !FileManager.default.fileExists(atPath: KTempDirectory) {
            try!FileManager.default.createDirectory(at: URL(fileURLWithPath: KTempDirectory, isDirectory: true), withIntermediateDirectories: true, attributes: nil)
        }
        return KTempDirectory
    }()
    static let tempRecoderPath: String = {
        ZFAudioFileTool().tempRecoderPath
    }()
    
    
}

// MARK: - 对外提供方法
extension ZFAudioFileTool {
    // 清除temp中的文件
    class func cleanTempdirection() {
        guard let paths = try?FileManager.default.contentsOfDirectory(atPath: tempRecoderPath) else {return}
        for path in paths {
            try?FileManager.default.removeItem(atPath: tempRecoderPath + "/" + path)
        }
    }
    // 返回合并后的音频路径
    func combineRecorderPath(_ recordercount: Int) -> String{
        return tempRecoderPath + "/combine\(recordercount).m4a"
    }
    // 播放第一段录制音频
    func firstRecorderPath() -> String {
        return tempRecoderPath + "/temp0.m4a"
    }
    
    // 录某一段的路径
     func createOneStageRecordPath(_ stageNum: Int) -> URL{
        let path = tempRecoderPath + "/temp\(stageNum).m4a"
        return URL(fileURLWithPath: path)
    }
    

    /// 删除上一段视频
    func deletePreviousAudio(_ recoders: [AVAudioRecorder]) {
        let recoderCount = recoders.count
        try?FileManager.default.removeItem(atPath: tempRecoderPath + "/temp\(recoderCount - 1).m4a")
        try?FileManager.default.removeItem(atPath: tempRecoderPath + "/combine\(recoderCount).m4a")
        
    }
    /// 剪辑一段视频
    class func cutAudio(_ audioPath: String, fromTime: CGFloat, toTime: CGFloat, outputPath: String, completed:@escaping () -> ()) {
        let asset = AVURLAsset(url: URL(fileURLWithPath: audioPath))
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)!
        exportSession.outputFileType = AVFileType.m4a
        exportSession.outputURL = URL(fileURLWithPath: outputPath)
        let startTime = CMTimeMake(Int64(fromTime), 1)
        let endTime = CMTimeMake(Int64(toTime), 1)
        exportSession.timeRange = CMTimeRangeFromTimeToTime(startTime, endTime)
        if FileManager.default.fileExists(atPath: outputPath) {
            try?FileManager.default.removeItem(atPath: outputPath)
        }
        exportSession.exportAsynchronously {
            if exportSession.status == .completed {
                DispatchQueue.main.async {
                    completed()
                }
            }
        }
        
    }
    /// 合并多段音频
    /// 生成一段包含多种轨道音乐的步骤:   exportsession -> AVAudioMix,AVMutableComposition -> AVMutableAudioMix -> [AVMutableAudioMixInputParameters] ->  AVMutableCompositionTrack.insert -> [AVAssetTrack] -> asset
    func combineAllRecorder(_ recoders: [AVAudioRecorder],_ backMusicPath: String?, completed:@escaping() -> ()) {
        let outputPath = tempRecoderPath + "/combine\(recoders.count).m4a"
        
        // 存放音频混合参数的数组
        var mixParams = [AVMutableAudioMixInputParameters]()
        
        // 用来添加track轨道的混合素材.
        let composition = AVMutableComposition()
        // 录音的轨道
        let recordMutableTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
        var insertTime = kCMTimeZero // 下一次插入录音段的起点
        // 往录音轨道中添加一段段音频
        for recorder in recoders {
            let asset = AVURLAsset(url: recorder.url)
            // 取出资源中的音频素材
            let track = asset.tracks(withMediaType: .audio)
            // 将音频素材插入到创建的录音轨道当中.
            try?recordMutableTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, asset.duration), of: track.first!, at: insertTime)
            insertTime = insertTime + asset.duration
        }
        // 从录音轨道中生成一个混音素材,添加到数组中.
        let trackMix = AVMutableAudioMixInputParameters(track: recordMutableTrack)
        mixParams.append(trackMix)
        
        // 插入背景音乐
        if let backMusicPath = backMusicPath {
            let backMutableTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
            let asset = AVURLAsset(url: URL(fileURLWithPath: backMusicPath))
            let track = asset.tracks(withMediaType: .audio).first!
            
            let duration = asset.duration > insertTime ? insertTime : asset.duration
            try?backMutableTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, duration), of: track, at: kCMTimeZero)
            let backTrackMix = AVMutableAudioMixInputParameters(track: backMutableTrack)
            // 背景音乐的音量
            backTrackMix.setVolume(0.4, at: CMTimeMake(0, 1))
            mixParams.append(backTrackMix)
        }
        // 创建一个可变的音频混音
        let audioMix = AVMutableAudioMix()
        // 将两个混音素材添加到混音对象中.
        audioMix.inputParameters = mixParams
        
        
        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)!
        exportSession.outputFileType = AVFileType.m4a
        // 如果有混音就设置这个参数.
        exportSession.audioMix = audioMix
        exportSession.outputURL = URL(fileURLWithPath: outputPath)
        exportSession.exportAsynchronously {
            if exportSession.status == .completed {
                completed()
            }
        }
    }

   
}
// MARK: - 方法抽取
extension ZFAudioFileTool {
    
    
    
    // 将某一段加到另一段的后面
    fileprivate func combineAudio(fromUrl: URL, toUrl: URL, outputPath: String, completed: @escaping () -> ()) {
        let asset2 = AVURLAsset(url: fromUrl)
        let asset1 = AVURLAsset(url: toUrl)
        let track2 = asset2.tracks(withMediaType: .audio).first!
        let track1 = asset1.tracks(withMediaType: .audio).first!
        
        let composition = AVMutableComposition()
        let mutableTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
        try!mutableTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, asset1.duration), of: track1, at: kCMTimeZero)
        try!mutableTrack.insertTimeRange(CMTimeRangeMake(kCMTimeZero, asset2.duration), of: track2, at: asset1.duration)
        
        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetAppleM4A)!
        exportSession.outputFileType = AVFileType.m4a
        exportSession.outputURL = URL(fileURLWithPath: outputPath)
        exportSession.exportAsynchronously {
            if exportSession.status == .completed {
                completed()
            }
        }
    }
}

