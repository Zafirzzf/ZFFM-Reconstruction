//
//  PlayerUserinfoCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerUserinfoCell: UITableViewCell, LoadNibCell{

    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var playCountBtn: UIButton!
    @IBOutlet weak var voiceCountBtn: UIButton!
    var albumVM: ZFPlayerAlbumVM? {
        didSet {
            setAlbumVM(albumVM)
        }
    }
    
    
 

    
}
//MARK: 父类方法
extension PlayerUserinfoCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
//MARK: 抽取方法
extension PlayerUserinfoCell {
    fileprivate func setAlbumVM(_ VM: ZFPlayerAlbumVM?) {
        headIcon.zf_setImage(with: VM?.coverSmall)
        nameLabel.text = VM?.title
        introduceLabel.text = VM?.intro
        playCountBtn.setTitle(VM?.shares, for: .normal)
        voiceCountBtn.setTitle(VM?.tracks, for: .normal)
        
    }
}











