//
//  ListenTodayVoiceCell.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
enum VoiceCellDownloadState {
    case wait
    case downloading
    case downloaded
}
class ListenTodayVoiceCell: UITableViewCell,LoadNibCell {

    @IBOutlet weak var sortNumLabel: UILabel!
    @IBOutlet weak var playOrPauseBtn: UIButton!
    @IBOutlet weak var voiceTitleLabel: UILabel!
    @IBOutlet weak var voiceAuthorLabel: UILabel!
    @IBOutlet weak var downloadBtn: UIButton!
    
    var downloadState: VoiceCellDownloadState = .wait {
        didSet {
        }
    }
    @objc var downloadBlock: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        playOrPauseBtn.layer.cornerRadius = playOrPauseBtn.bounds.width / 2
        playOrPauseBtn.layer.masksToBounds = true
    }

    @IBAction func playOrPauseClick(_ sender: UIButton) {
        
    }
    
    
    @IBAction func downloadClick(_ sender: UIButton) {
        downloadBlock?()
    }
}
