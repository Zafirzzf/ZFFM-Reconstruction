//
//  ZFPlayerPane.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/1.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFPlayerPane: UIView, LoadNibable {
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var headIconImageV: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var VIcon: UIImageView!
    
    @IBOutlet weak var middleImageV: UIImageView!
    @IBOutlet weak var rateControllerView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    

    @IBOutlet weak var rateNumBtn: PlayerRateBtn!
    @IBOutlet weak var progressSlider: UISlider!

    @objc let player = ZFRemotePlayer.shareInstance
    @objc var time = Timer()
    fileprivate var rateViewHideSec = 0 // rateView消失倒计时
    fileprivate var isDragingSlider = false // 拖动进度条时停止更新slider
    var playerPaneVM: ZFPlayerPaneVM? {
        didSet {
            setViewModel(playerPaneVM)
        }
    }
    
}
//MARK: 父类方法
extension ZFPlayerPane {
    override func awakeFromNib() {
        headIconImageV.layer.masksToBounds = true
        headIconImageV.layer.cornerRadius = headIconImageV.zf_width * 0.5
        zf_height =  44 + 80 + KSCREEN_W * 0.8
        player.delegate = self
        rateControllerView.alpha = 0
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
}
//MARK: 数据赋值
extension ZFPlayerPane {

    fileprivate func setViewModel(_ VM: ZFPlayerPaneVM?) {
        guard let VM = VM else {return}
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        RunLoop.current.add(time, forMode: .commonModes)
        
        headIconImageV.zf_setImage(with: VM.headIcon)
        titleLabel.text = VM.nickName
        middleImageV.zf_setImage(with: VM.middleImage)
        
        ZFTabBarMiddleView.shareInstance.iconImageView.zf_setImage(with: playerPaneVM?.middleImage)
        if VM.downloadUrl.count > 0 { // 如果是本地下载列表的声音.
            player.playWithUrlStr(VM.downloadUrl, isCache: true)
        }else {
            player.playWithUrlStr(VM.playUrlStr, isCache: true)
        }
        
    }
}


//MARK: 事件响应
extension ZFPlayerPane {
    
    @objc fileprivate func update() {
        currentTimeLabel.text = player.currentTimeFormat
        totalTimeLabel.text = player.totalTimeformat
        if !isDragingSlider {
            progressSlider.value = Float(player.progress)
        }
        
        playBtn.isSelected = player.state.rawValue == 2
        rateViewHideSec -= 1 // 刷新面板状态
        if rateViewHideSec == 0 {
            UIView.animate(withDuration: 0.6, animations: {
                self.rateControllerView.alpha = 0
            })
        }
    }
        
    @IBAction func playOrPause(_ sender: UIButton) {
        player.playOrPause()
        sender.isSelected = !sender.isSelected
    }
    // 快退
    @IBAction func backProgressClick(_ sender: Any) {
        rateViewHideSec = 5
        player.seekToTimeDiffer(-15)
        update()
    }
    // 快进
    @IBAction func forwardProgressClick(_ sender: Any) {
        rateViewHideSec = 5
        player.seekToTimeDiffer(15)
        update()
    }
    // 切换速率
    @IBAction func rateChangeClick(_ sender: UIButton) {
        rateViewHideSec = 5
        rateNumBtn.changeRate()
        player.setRate(rateNumBtn.rate)
        update()
    }
    // 拖动进度条
    @IBAction func pullProgressSlider(_ sender: UISlider) {
        player.seekToProgress(sender.value)
        isDragingSlider = false
    }
    @IBAction func dragInside(_ sender: UISlider) {
        isDragingSlider = true
    }
    
    
    @IBAction func playListClick(_ sender: Any) {
    }
    // 上一曲
    @IBAction func preBtnClick(_ sender: Any) {
     
    }
    // 下一曲
    @IBAction func forwardBtnClick(_ sender: Any) {

    }
    // 点击弹幕
    @IBAction func danmuClick(_ sender: UIButton) {
    }
    // 点击中央缩略图
    @IBAction func tapMiddleimageV(_ sender: UITapGestureRecognizer) {
        hideOrShowRateView()
    }
    
    @IBAction func swipMiddleimageV(_ sender: UISwipeGestureRecognizer) {
    }
    
}
// MARK: - 对外提供方法
extension ZFPlayerPane  {
    @objc func resetPlane() {
        currentTimeLabel.text = "00:00"
        totalTimeLabel.text = "00:00"
        progressSlider.value = 0
        playBtn.isSelected = false
        playBtn.isEnabled = false
        time.invalidate()
    }
}

// MARK: - 事件抽取
extension ZFPlayerPane {
    /// 显示或隐藏播放速率视图
    fileprivate func hideOrShowRateView() {
        
        UIView.animate(withDuration: 0.6, animations: {
            self.rateControllerView.alpha = self.rateControllerView.alpha > 0.5 ? 0 : 1

        }) { (finish) in
            if self.rateControllerView.alpha == 1 {
                self.rateViewHideSec = 5
            }
        }
    }

    
}


// MARK: - 播放器代理
extension ZFPlayerPane: ZFPlayerDelegate {
    func zf_playerItemReadyToPlay(_ player: ZFRemotePlayer) {
        self.playBtn.isEnabled = true
        
    }
    
    func zf_playerStateChange(_ player: ZFRemotePlayer,  _ state: ZFRemotePlayerState) {
        ZFTabBarMiddleView.shareInstance.isPlaying = state == .playing
    }
    
}






