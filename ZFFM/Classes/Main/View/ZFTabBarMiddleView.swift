//
//  ZFTabBarMiddleView.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/20.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class ZFTabBarMiddleView: UIView, LoadNibable,PushPlayerVC {

    @objc static var shareInstance: ZFTabBarMiddleView = ZFTabBarMiddleView.loadFromNib()
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    
    fileprivate var albumId = ""
    fileprivate var trackId = ""
    @objc var isPlaying: Bool = false {
        didSet {
            guard oldValue != isPlaying else {return}
            switchPlayStatus(isPlaying)
        }
    }
  
    private init(){
        super.init(frame: CGRect.zero)
    }
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addAnimation()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.zf_width * 0.5
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
// MARK: - 对外提供方法
extension ZFTabBarMiddleView {
    @objc func setPlayInfo(_ albumId: String, _ trackId: String) {
        self.albumId = albumId
        self.trackId = trackId
    }
}

//MARK:- 事件响应
extension ZFTabBarMiddleView {
    @IBAction func playBtnClick(_ sender: UIButton) {
        if isPlaying {
            pushPlayerVC(albumId, trackId)
        }else {
            ZFRemotePlayer.shareInstance.playOrPause()
        }
    }
    // 切换播放状态
     @objc func switchPlayStatus(_ isplay: Bool) {
        isPlaying = isplay
        if isplay { // 开始播放
            playBtn.setImage(nil, for: .normal)
            iconImageView.layer.resumeAnimate()
        }else {
            let image = UIImage(named: "tabbar_np_play")
            playBtn.setImage(image, for: .normal)
            iconImageView.layer.pauseAnimate()
        }
    }
    fileprivate func addAnimation() {
        let ani = CABasicAnimation(keyPath: "transform.rotation.z")
        ani.fromValue = 0
        ani.toValue = Double.pi * 2
        ani.duration = 30
        ani.repeatCount = MAXFLOAT
        ani.isRemovedOnCompletion = false
        iconImageView.layer.add(ani, forKey: "playAnimation")
        iconImageView.layer.pauseAnimate()
    }
}





