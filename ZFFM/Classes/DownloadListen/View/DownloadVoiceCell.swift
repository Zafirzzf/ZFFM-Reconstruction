//
//  DownloadVoiceCell.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/15.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class DownloadVoiceCell: UITableViewCell,LoadNibCell {

    @IBOutlet weak var playOrPauseBtn: UIButton!
    @IBOutlet weak var voiceTitleLabel: UILabel!
    @IBOutlet weak var voiceAuthorLabel: UILabel!
    @IBOutlet weak var filesizeLabel: UILabel!
    @IBOutlet weak var playCountBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var durationBtn: UIButton!

    @IBOutlet weak var progressBackView: UIView!
    @IBOutlet weak var downloadOrPauseBtn: UIButton!
    @IBOutlet weak var downloadProgressLabel: UILabel!
    
    @IBOutlet weak var downloadProgressV: UIProgressView!
    @objc var playURL: URL?
    @objc var trackID = ""
    
    @objc var deleteClick: (() -> ())?
    @objc var playOrPauseClick: (() -> ())?
    @objc var downloadOrPauseClick: ( () -> () )?
    override func awakeFromNib() {
        super.awakeFromNib()
        playOrPauseBtn.layer.cornerRadius = playOrPauseBtn.bounds.width / 2
        playOrPauseBtn.layer.masksToBounds = true
        playOrPauseBtn.layer.borderWidth = 3
        playOrPauseBtn.layer.borderColor = UIColor.white.cgColor
    }
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            super.frame.origin.y += (1 / UIScreen.main.scale)
            super.frame.size.height -= (1 / UIScreen.main.scale)
        }
    }


    
}
//MARK:- 事件响应
extension DownloadVoiceCell {
    @IBAction func deleteClick(_ sender: Any) {
        deleteClick?()
    }
    
    @IBAction func playOrPause(_ sender: UIButton) {
        playOrPauseClick?()
    }
    
    @IBAction func downloadOrPause(_ sender: UIButton) {
        downloadOrPauseClick?()
    }
    
}






