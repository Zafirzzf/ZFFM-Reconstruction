//
//  ZFRewardView.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/7.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFRewardView: UIView,LoadNibable {

    @IBOutlet weak var descriptionBtn: UIButton!
    @IBOutlet weak var rewwardCountBtn: UIButton!
    @IBOutlet weak var btnContainerView: UIView!
    
    @objc var trackRewardModel = TrackRewardModel() {
        didSet {
            descriptionBtn.setTitle(trackRewardModel.voiceIntro, for: .normal)
            rewwardCountBtn.setTitle("共有\(trackRewardModel.rewords.count)人打赏", for: .normal)
            btnContainerView.isHidden = !(trackRewardModel.rewords.count > 0)
            if trackRewardModel.rewords.count > 0 {
                addRewardUser()
            }
        }
    }
    
    @objc var viewHeight: CGFloat {
        return 145 + (trackRewardModel.rewords.count > 0 ? 55 : 0)
    }
    
    @objc func addRewardUser() {
        for reward in trackRewardModel.rewords {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageView.center = CGPoint(x: btnContainerView.zf_width / 2, y: btnContainerView.zf_height / 2)
            imageView.zf_setCircularImage(reward.smallLogo)
            btnContainerView.addSubview(imageView)
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func rewardClick(_ sender: UIButton) {
    }
    @IBAction func introduceClick(_ sender: UIButton) {
    }
}
