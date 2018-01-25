//
//  RecorderController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class RecorderController: UIViewController {
        
    @IBOutlet weak var volumeLevelView: AudioShowVolumeView!
    @IBOutlet weak var totalTImeLabel: UILabel!
    @IBOutlet weak var backMusicBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var preListenBtn: UIButton!
    
    fileprivate let recorder = ZFAudioRecorder()
    fileprivate var timer = Timer()
    fileprivate lazy var player = ZFAudioPlayer(delegate: self)
    fileprivate var backMusicPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
        recorder.resetRecorder() // 先清除temp里数据,实际项目中根据存放位置而定
    }
  

    
}

// MARK: - 事件响应
extension RecorderController {
    @objc func timeUpdate() {
        volumeLevelView.currentVolume = recorder.getCurrentTimeVolume()
        totalTImeLabel.text = String(format: "%02d:%02.0f", Int(recorder.totalRecorderTime) / 60, recorder.totalRecorderTime.truncatingRemainder(dividingBy: 60))
    }
    @IBAction func startRecord(_ sender: UIButton) {
        recorder.startRecoder()
        if let backMusicPath = backMusicPath {
            player.playLocalAudio(URL(fileURLWithPath: backMusicPath))
            player.playToTimeOffset(recorder.totalRecorderTime)
        }
    }
    @IBAction func endRecord(_ sender: UIButton) {
        recorder.endRecoder()
        player.pausePlay()
    }
    
    @IBAction func addBackMusic(_ sender: UIButton) {
        let selVC = SelectBackMusicVC()
        selVC.selectedBackMusic = { (audioPath,musicName) in
            sender.setTitle(musicName, for: .normal)
            self.backMusicPath = audioPath
        }
        navigationController?.pushViewController(selVC, animated: true)
    }
    @IBAction func preListenClick(_ sender: UIButton) {
        if sender.isSelected {
            player.stopPlay()
            sender.isSelected = false
        }else {
            recorder.createAudio(backMusicPath) {[weak self] (outUrl) in
                guard let url = outUrl else {return}
                self?.player.playLocalAudio(url)
            }
            sender.isSelected = true
        }
    }
   
    @IBAction func undoClick(_ sender: UIButton) {
        recorder.deleteLastRecord()
        timeUpdate()
    }
    @IBAction func resetRecorder(_ sender: UIButton) {
        recorder.resetRecorder()
        timeUpdate()
    }
}
extension RecorderController: ZFAudioPlayerDelegate {
    func audioplayerDidFinished(_ player: ZFAudioPlayer, success: Bool) {
        preListenBtn.isSelected = false
    }
}










