//
//  MineTableHeaderView.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/4.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineTableHeaderView: UIView, LoadNibable {

    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var backContainerView: UIView!
    
    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!

    @objc var setupBtnClick: (() -> ())?
    @objc var itemListClick: (() -> ())?
    @objc var recordBtnClick: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headIcon.layer.cornerRadius = headIcon.bounds.width * 0.5
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
}

// MARK: - 事件响应
extension MineTableHeaderView {
    @IBAction func setupBtnClick(_ sender: UIButton) {
        setupBtnClick?()
    }
    @IBAction func itemListClick(_ sender: UIButton) {
        itemListClick?()
    }
    @IBAction func recordBtnClick(_ sender: UIButton) {
        recordBtnClick?()
    }
}
