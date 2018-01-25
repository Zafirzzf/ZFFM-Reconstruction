//
//  ZFAudioRecorder.swift
//  ZFAudioRecorder
//
//  Created by 周正飞 on 2017/11/28.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import AVFoundation
enum ZFRecorderErr: Error {
    case initalRecoderError
}
/// 这是一个刻意为"多段录音"所服务的类. 类似抖音的音频录制版.
class ZFAudioRecorder {
    
    init() {
        settingAudioSession()
    }
    
    
    fileprivate lazy var fileTool = ZFAudioFileTool()
    /// 存放多段录音器的数组
    fileprivate lazy var recorders = [AVAudioRecorder]()
    
    fileprivate var recordSettings:[String: Any] = {
        // 2. 设置录音参数
        var recordSettings = [String:Any]()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC // 编码格式
        recordSettings[AVSampleRateKey] = 11025.0 // 采样率
        recordSettings[AVNumberOfChannelsKey] = 1 // 通道数
        recordSettings[AVEncoderAudioQualityKey] = kRenderQuality_Min // 音频质量
        return recordSettings
    }()
    
    /// 存放各recorder录制的时间段
    var recordersDuration = [TimeInterval]()
    /// 当前录制音频的总时间
    var totalRecorderTime: CGFloat {
        get {
            guard recorders.count > 0 else {return 0}
            return CGFloat(recordersDuration.reduce(0,+) + recorders.last!.currentTime)
        }
    }
}

// MARK: - 对外提供的API
extension ZFAudioRecorder {
    /// 开始录音
    func startRecoder() {
        let recorder = try! AVAudioRecorder(url: fileTool.createOneStageRecordPath(recorders.count), settings: recordSettings)
        recorder.isMeteringEnabled = true
        recorders.append(recorder)
        recorders.last!.record()
        
        
    }
    /// 暂停录音
    func pauseRecoder() {
        recorders.last!.pause()
    }
    /// 结束录音
    func endRecoder() {
        // 记录时间
        recordersDuration.append(recorders.last!.currentTime)
        // 停止
        recorders.last!.stop()
    }
    
    /// 删除最后一段录音
    func deleteLastRecord() {
        recordersDuration.removeLast()
        fileTool.deletePreviousAudio(recorders)
        recorders.removeLast()
    }
    /// 重新录音
    func resetRecorder() {
        recorders.removeAll()
        recordersDuration.removeAll()
        ZFAudioFileTool.cleanTempdirection()
    }
    /// 合成并播放录音
    func createAudio(_ backMusicPath: String?, _ completion: @escaping ((_ outputUrl: URL?) -> ())) {
        guard recorders.count > 0 else { completion(nil);  return}
        
        if recorders.count == 1 && backMusicPath == nil{
            completion(recorders.first!.url)
        }else {
            let outputPath = fileTool.combineRecorderPath(recorders.count)
            if FileManager.default.fileExists(atPath: outputPath) {
                 completion(URL(fileURLWithPath: outputPath))
            }else {
                fileTool.combineAllRecorder(recorders, backMusicPath, completed: {
                    completion(URL(fileURLWithPath: outputPath))
                })
            }
        }
    }

    
    func getCurrentTimeVolume() -> CGFloat {
        guard recorders.count > 0 else {return 0}
        recorders.last!.updateMeters()
        guard let power = recorders.last?.peakPower(forChannel: 0) else {print("channel0没有声音");return 0;}
        
        var level: Float
        let minDecibels: Float = -60
        if power < minDecibels {
            level = 0
        }else if power >= 0 {
            level = 1
        }else {
            let root: Float = 2
            let minAmp: Float = powf(10, 0.05 * minDecibels)
            let inverseAmpRange = 1.0 / (1.0  - minAmp)
            let amp: Float = powf(10, 0.05 * power)
            let adjAmp: Float = (amp - minAmp) * inverseAmpRange
            level = powf(adjAmp, 1.0 / root)
        }
        return CGFloat(level * 150)
    }
    
}
// MARK: - 方法抽取
extension ZFAudioRecorder {
    fileprivate func settingAudioSession() {
        // category参数的含义,options?
        try?AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)//录音时候允许播放
        try?AVAudioSession.sharedInstance().setActive(true)
    }
}








