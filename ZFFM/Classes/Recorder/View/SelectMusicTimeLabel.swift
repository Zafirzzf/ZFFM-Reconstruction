//
//  SelectMusicTimeLabel.swift
//  ZFAudioRecoder
//
//  Created by 周正飞 on 2017/12/1.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class SelectMusicTimeLabel: UILabel {

    @objc var timeSec: CGFloat = 0 {
        didSet {
            timeFormat = String(format: "%02d:%02.0f", Int(timeSec) / 60, timeSec.truncatingRemainder(dividingBy: 60))
            text = timeFormat
        }
    }
    fileprivate var timeFormat: String = "00:00"
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.black
        font = UIFont.systemFont(ofSize: 13)
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
