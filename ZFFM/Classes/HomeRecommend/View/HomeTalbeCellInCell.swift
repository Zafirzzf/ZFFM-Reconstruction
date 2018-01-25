//
//  HomeTalbeCellInCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeTalbeCellInCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var middleTitleLabel: UILabel!
    @IBOutlet weak var bottomTitleLabel: UILabel!
    
    @objc var itemCellModel = HomeItemCellModel() {
        didSet {
         setupModel(itemCellModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}
//MARK:- 数据赋值
extension HomeTalbeCellInCell {
    fileprivate func setupModel(_ model: HomeItemCellModel) {
        iconImageView.zf_setImage(with: model.coverPath)
        topTitleLabel.text = model.title
        middleTitleLabel.text = model.subtitle
        bottomTitleLabel.text = model.footnote
    }
}
