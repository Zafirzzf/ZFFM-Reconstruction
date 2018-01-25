//
//  ZFSegmentBtn.swift
//  ZFSegmentBar
//
//  Created by 周正飞 on 2017/8/21.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFSegmentBtn: UIButton {

    var lineColor = UIColor.orange {
        didSet {
            lineView.backgroundColor = lineColor
        }
    }
    var lineView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    fileprivate func addLine() {
        let lineW = (titleLabel!.text! as NSString).size(withAttributes: [NSAttributedStringKey.font: self.titleLabel!.font]).width
        let lineView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: lineW + 5, height: 2)))
        lineView.center = CGPoint(x: frame.width / 2, y: frame.maxY - 2)
        lineView.backgroundColor = lineColor
        lineView.isHidden = true
        self.lineView = lineView
        addSubview(lineView)
    }
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        addLine()
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.isSelected = newValue
            self.lineView.isHidden = !isSelected
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
