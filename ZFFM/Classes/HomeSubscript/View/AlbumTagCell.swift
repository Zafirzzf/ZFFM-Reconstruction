//
//  AlbumTagCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/22.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumTagCell: UITableViewCell, LoadNibCell {

    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var tagButtonView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tagButton.layer.borderWidth = 0.5
        tagButton.layer.borderColor = UIColor.orange.cgColor
        tagButton.layer.cornerRadius = 4
        tagButton.layer.masksToBounds = true
        selectionStyle = .none

    }

    @IBAction func tagButtonClick(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
