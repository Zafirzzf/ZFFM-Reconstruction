//
//  ZFRemotePlayer.swift
//  ZFRemotePlayer(播放器)
//
//  Created by 周正飞 on 2017/9/29.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import AVFoundation
@objc protocol ZFPlayerDelegate {
    @objc optional func zf_playerItemReadyToPlay(_ player: ZFRemotePlayer)
    @objc optional func zf_playerStateChange(_ player: ZFRemotePlayer,  _ state: ZFRemotePlayerState)
}
@objc enum ZFRemotePlayerState: Int {
    case unknow
    case loading
    case playing
    case stopped
    case pause
    case failed
}


class ZFRemotePlayer: NSObject {
    static var shareInstance = ZFRemotePlayer()
    var delegate: ZFPlayerDelegate?
    fileprivate var player = AVPlayer()
    
    
 var state: ZFRemotePlayerState = .unknow {
        didSet {
            print("播放状态", state)
            delegate?.zf_playerStateChange?(self, state)
        }
    }
    // 播放暂停
    var isUserPause = false
    // 总时间
    var totalTimeSec: CGFloat {
        guard let totalTime = player.currentItem?.duration else {return 0}// 总时长
        let totalSec = CMTimeGetSeconds(totalTime)
        guard totalSec > 0 else {return 0}
        return CGFloat(totalSec)
        
    }
    // 当前播放的时间
    var currentTimeSec: CGFloat{
        guard let playTime = player.currentItem?.currentTime() else {return 0}
        return CGFloat(CMTimeGetSeconds(playTime))
    }
    @objc var currentTimeFormat: String {
        return String(format: "%02d:%02.0f", Int(currentTimeSec) / 60, currentTimeSec.truncatingRemainder(dividingBy: 60))
        
    }
    @objc var totalTimeformat: String {
        return String(format: "%02d:%02.0f", Int(totalTimeSec) / 60, totalTimeSec.truncatingRemainder(dividingBy: 60))
    }

    // 当前进度
    var progress: CGFloat {
        return CGFloat(self.currentTimeSec / self.totalTimeSec)
    }
    // 缓存进度
    var loadDataProgress: CGFloat {
        
        guard let timeRange = player.currentItem?.loadedTimeRanges.last?.timeRangeValue else {return 0}
        let loadedTime = CMTimeAdd(timeRange.start, timeRange.duration)
        let loadedTimeSec = CMTimeGetSeconds(loadedTime)
        return CGFloat(loadedTimeSec) / totalTimeSec
        
    }
    // 当前的播放地址
    var playUrl: URL?
    // 是否静音
    var isMuted = false
    // 加载资源代理
    var resourceLoader = ZFPlayerResourceLoader()
    
    

    private override init() {
        
    }
    
}

//MARK:- KVO监听的方法
extension ZFRemotePlayer {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" { // 播放初会走这个方法
            let status = change![NSKeyValueChangeKey.newKey] as! Int
            if status == AVPlayerItemStatus.readyToPlay.hashValue {
                resumePlay()
                delegate?.zf_playerItemReadyToPlay?(self)
            }else {
                state = .unknow
            }
        }else if keyPath == "playbackLikelyToKeepUp" { // 播放的过程当中走这些方法
            let isKeepUP = change![NSKeyValueChangeKey.newKey] as! Bool
            if isKeepUP { // 资源准备好
                if !isUserPause { resumePlay() }
                
            }else { // 资源加载不足
                state = .loading
            }
        }
    }
}

//MARK:- 对外提供的方法
extension ZFRemotePlayer {
    // 播放某一个资源
    func playWithUrlStr(_ urlStr: String, isCache: Bool = false ) {
        guard var url = URL(string: urlStr) else {return}
        if playUrl == url { // 还是之前的资源
            resumePlay()
        }
        
        playUrl = url
        if isCache {
            url = url.streamingURL()
        }
        let playAsset = AVURLAsset(url: url)
        let newLoader = ZFPlayerResourceLoader()
        resourceLoader = newLoader
        playAsset.resourceLoader.setDelegate(resourceLoader, queue: DispatchQueue.main)
        let playItem = AVPlayerItem(asset: playAsset)
        // 监听
        playItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        playItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
        // 通知
        NotificationCenter.default.addObserver(self, selector: #selector(playEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playInterrupt), name: NSNotification.Name.AVPlayerItemPlaybackStalled, object: nil)
        player = AVPlayer(playerItem: playItem)
        
    }
    // 暂停或播放
    func playOrPause() {
        if isUserPause {
            resumePlay()
        }else {
            pausePlay()
        }
    }
    // 暂停播放
    func pausePlay() {
        player.pause()
        isUserPause = true
        if playUrl != nil {
            state = .pause
        }
    }
    // 继续播放
    func resumePlay() {
        player.play()
        if player.currentItem?.isPlaybackLikelyToKeepUp ?? false{
            state = .playing
            isUserPause = false
        }
    }
    // 停止播放
    func stopPlay() {
        player.pause()
        if playUrl != nil {
            state = .stopped
        }
    }
    // 播放进度百分比
    func seekToProgress(_ progress: Float) {
        guard progress >= 0 && progress <= 1.0 else {return}
        guard totalTimeSec != 0 else {return}
        pausePlay()
        let targetSec = Float64(totalTimeSec) * Float64(progress)
        let targetTime = CMTimeMake(Int64(targetSec), 1)
        resourceLoader.isSeekProgress = true
        player.seek(to: targetTime) { (finished) in
            if finished { // 确定加载这个时间点的资源
                self.resumePlay()
            }else { // 取消加载这个时间点的资源
//                self.pausePlay()
            }
        }
    }
    // 进度进行某一程度偏移
    func seekToTimeDiffer(_ timeDiffer: CGFloat) {
        guard totalTimeSec != 0 else {return}
        var playSec = currentTimeSec
        playSec += timeDiffer
        
        let targetProgress = playSec * 1.0 / totalTimeSec * 1.0
        seekToProgress(Float(targetProgress))
        
    }
    // 播放的速率
    func setRate(_ rate: Float) {
        player.rate = rate
    }
    
    // 播放的音量
    func setVolume(_ volume: Float) {
        guard volume >= 0 && volume <= 1 else {return}
        player.volume = volume
        
        if volume > 0 {
            isMuted = false
            player.isMuted = false
        }
        
    }
    // 静音开关
    func setMute(){
        isMuted = !isMuted
        player.isMuted = isMuted
    }
}
//MARK:- 数据/事件抽取
extension ZFRemotePlayer {
    // 播放完毕
    @objc func playEnd() {
        print("播放完毕")
        
    }
    // 播放被打断(来电话等,资源加载跟不上)
    @objc func playInterrupt() {
        state = .pause
        print("播放被打断")
    }
    
}

extension URL {
    func streamingURL() -> URL{
        var compents = URLComponents(string: absoluteString)
        compents?.scheme = "streaming"
        return compents!.url!
    }
    func httpURL() -> URL{
        var compents = URLComponents(string: absoluteString)
        compents?.scheme = "http"
        return compents!.url!
    }
    
}






