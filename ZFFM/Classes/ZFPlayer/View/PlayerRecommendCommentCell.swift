//
//  PlayerRecommendCommentCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class PlayerRecommendCommentCell: UITableViewCell,LoadNibCell {

    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    @objc var commentInfo: CommentInfoModel? {
        didSet {
            guard let model = commentInfo else {return}
            iconImageV.zf_setCircularImage(model.smallHeader, #imageLiteral(resourceName: "iconPlaceholder"), backColor: UIColor.white)
            nicknameLabel.text = model.nickname
            contentLabel.text = model.content
            dataLabel.text = model.createdAt
            likeBtn.setTitle(model.likes, for: .normal)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        commentInfo?.oneCommentHeight = frame.height

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

    }
    

    @IBAction func likeBtnClick(_ sender: UIButton) {
        
    }

    
}
