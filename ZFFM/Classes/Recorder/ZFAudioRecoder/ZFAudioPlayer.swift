//
//  ZFAudioPlay.swift
//  ZFAudioRecoder
//
//  Created by 周正飞 on 2017/11/29.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import AVFoundation
@objc  protocol ZFAudioPlayerDelegate {
   @objc optional func audioplayerDidFinished(_ player: ZFAudioPlayer,  success: Bool)
}
class ZFAudioPlayer: NSObject {
    
     var player: AVAudioPlayer?
     var delegate: ZFAudioPlayerDelegate?
    
    /// 是否正在播放
    var isPlaying: Bool {
        get {
            return player?.isPlaying ?? false
        }
    }
    /// 播放进度
    var progress: CGFloat  {
        get {
            guard let player = player else {return 0}
            return CGFloat(player.currentTime / player.duration)
        }
    }
    /// 播放总时长
    var duration: CGFloat {
        get {
            guard let player = player else {return 0}
            return CGFloat(player.duration)
        }
    }
    convenience init(delegate: ZFAudioPlayerDelegate) {
        self.init()
        self.delegate = delegate
    }
}

// MARK: - 对外提供方法
extension ZFAudioPlayer {
    func playLocalAudio(_ url: URL) {
        guard let player = try?AVAudioPlayer(contentsOf: url) else {return}
        self.player = player
        player.delegate = self
        player.play()
    }
    
    func pausePlay() {
        guard let player = player else {return}
        player.pause()
    }
    
    func playToTimeOffset(_ timeOffset: CGFloat) {
        guard let player = player else {return}
        player.currentTime = TimeInterval(timeOffset)
        player.play()
    }
    func playToProgress(_ progress: CGFloat) {
        guard let player = player else {return}
        player.currentTime = player.duration * TimeInterval(progress)
        player.play()
    }

    func stopPlay() {
        guard let player = player else {return}
        player.stop()
    }
}

extension ZFAudioPlayer: AVAudioPlayerDelegate {

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.delegate?.audioplayerDidFinished!(self, success: flag)
    }
    
}
