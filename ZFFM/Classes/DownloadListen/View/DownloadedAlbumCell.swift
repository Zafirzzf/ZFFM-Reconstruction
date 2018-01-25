//
//  DownloadedAlbumCell.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/15.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class DownloadedAlbumCell: UITableViewCell,LoadNibCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumAnthorLabel: UILabel!
    @IBOutlet weak var albumPartsBtn: UIButton!
    @IBOutlet weak var albumPartsSizeBtn: UIButton!
    @objc var deleteClick: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    @IBAction func deleteClick(_ sender: UIButton) {
        deleteClick?()
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
