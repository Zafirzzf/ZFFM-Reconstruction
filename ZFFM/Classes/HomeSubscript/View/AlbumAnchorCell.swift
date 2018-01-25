//
//  AlbumAnchorCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/22.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumAnchorCell: UITableViewCell, LoadNibCell {

    @IBOutlet weak var anchorImageView: UIImageView!
    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var followCountLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var introLabel: UILabel!
    @objc var anchorInfo: AnchorInfo? {
        didSet {
            guard let info = anchorInfo else {return }
            anchorImageView.zf_setImage(with: info.smallLogo)
            anchorNameLabel.text = info.ptitle
            followCountLabel.text = String.init(format: "已被%.1f万人关注", Double(info.followers) ?? 0 / 10000.0)
            introLabel.text = info.personalSignature
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
