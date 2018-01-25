//
//  PlayerRecommendAlbumCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerRecommendAlbumCell: UITableViewCell, LoadNibCell {

    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var playCountLabel: UIButton!
    @IBOutlet weak var trackCountLabel: UIButton!
    @objc var albumInfo: AlbumInfoModel? {
        didSet{
            guard let model = albumInfo else {return}
            iconImageV.zf_setImage(with: model.coverSmall)
            titleLabel.text = model.title
            introLabel.text = model.intro
            playCountLabel.setTitle(model.playsCounts, for: .normal)
            trackCountLabel.setTitle(model.tracks, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        albumInfo?.cellHeight = frame.height
    }

    
}
