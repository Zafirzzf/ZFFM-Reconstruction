//
//  AlbumRecommondsCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/22.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumRecommondsCell: UITableViewCell,LoadNibCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recResonLabel: UILabel!
    @IBOutlet weak var playsCountsBtn: UIButton!
    @IBOutlet weak var tracksBtn: UIButton!
    @objc var recommend: OtherRecommand? {
        didSet {
            guard let recommend = recommend else {return}
            coverImageView.zf_setImage(with: recommend.coverSmall)
            titleLabel.text = recommend.title
            recResonLabel.text = recommend.intro
            playsCountsBtn.setTitle(recommend.playsCounts, for: .normal)
            tracksBtn.setTitle(recommend.tracks, for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
