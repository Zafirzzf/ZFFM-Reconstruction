//
//  HomeItemCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/5.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeItemCell: UICollectionViewCell {

    @IBOutlet weak var albumCoverImageV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var payIcon: UIImageView!
    
    @objc var itemCellModel = HomeItemCellModel() {
        didSet {
            setModel(itemCellModel)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
extension HomeItemCell {
    fileprivate func setModel(_ model: HomeItemCellModel) {
        albumCoverImageV.zf_setImage(with: model.coverMiddle)
        titleLabel.text = model.trackTitle
        detailLabel.text = model.title
        payIcon.isHidden = model.isPaid
    }
}












