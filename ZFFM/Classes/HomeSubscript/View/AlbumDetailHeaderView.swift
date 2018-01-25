//
//  AlbumDetailHeaderView.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/14.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumDetailHeaderView: UIView, LoadNibable {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playTimesLabel: UILabel!
    @IBOutlet weak var nickNameBtn: UIButton!
    @IBOutlet weak var categroyNameBtn: UIButton!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var downloadBtn: UIButton!
    
    @objc var album: Album? {
        didSet {
            guard let album = album else {return}
            coverImageView.zf_setImage(with: album.coverSmall)
            titleLabel.text = album.title
            playTimesLabel.text = album.playTimes
            nickNameBtn.setTitle(album.nickname, for: .normal)
            categroyNameBtn.setTitle(album.categoryName, for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        subscribeBtn.layer.masksToBounds = true
        downloadBtn.layer.borderColor = UIColor(r: 139, g: 195, b: 74).cgColor
        downloadBtn.layer.borderWidth = 2
        downloadBtn.layer.masksToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        subscribeBtn.layer.cornerRadius = 4
        downloadBtn.layer.cornerRadius = 4
        frame = CGRect(x: 0, y: 0, width: KSCREEN_W, height: 205)

    }
    
}
//MARK: 事件响应
extension AlbumDetailHeaderView {
    
    @IBAction func nickNameClick(_ sender: Any) {
    }
    @IBAction func subscribeClick(_ sender: UIButton) {
    }
    
    @IBAction func downloadClick(_ sender: UIButton) {
    }
}

