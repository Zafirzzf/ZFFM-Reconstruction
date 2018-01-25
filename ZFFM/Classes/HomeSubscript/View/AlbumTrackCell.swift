//
//  AlbumTrackCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/23.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumTrackCell: UITableViewCell, LoadNibCell {

    @IBOutlet weak var coverLogoBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var playNumBtn: UIButton!
    @IBOutlet weak var commentNumBtn: UIButton!
    @IBOutlet weak var timeBtn: UIButton!
    @objc var trackModel: TrackInfo? {
        didSet {
            guard let track = trackModel else {return}
            coverLogoBtn.zf_setImage(url: URL(string: track.smallLogo))
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd"
            let date = Date(timeIntervalSince1970: Double(track.createdAt)!)
            dataLabel.text = formater.string(from: date)
            playNumBtn.setTitle(String.init(format: "%.2f万", track.playtimes / 10000), for: .normal)
            commentNumBtn.setTitle("评论:" +  track.comments, for: .normal)
            timeBtn.setTitle(String.init(format: "时长:%zd:%zd", Int(track.duration) / 60, Int(track.duration) % 60), for: .normal)
            titleLabel.text = track.title
            titleLabel.sizeToFit()
            track.cellHeight = titleLabel.zf_height + 49
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
