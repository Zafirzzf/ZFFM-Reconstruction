//
//  AlbumDetailContentCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/22.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumDetailContentCell: UITableViewCell, LoadNibCell {

    @IBOutlet weak var introLabel: UILabel!
    @objc var albumDetailInfo: AlbumDetailInfo? {
        didSet {
            guard let info = albumDetailInfo else {return}
            introLabel.text = info.intro
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
