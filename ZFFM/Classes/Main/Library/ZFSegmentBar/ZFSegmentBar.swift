//
//  ZFSegmentBar.swift
//  ZFSegmentBar
//
//  Created by 周正飞 on 2017/8/21.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
protocol ZFSegmentBarDelegate {
    func segmentBar(_ segmentBar: ZFSegmentBar, index didSelectIndex: Int)
}

class ZFSegmentBar: UIView {

    var titles: [String] = []
    var titleFont: CGFloat = 14 {
        didSet {
           _ = buttons.map{$0.titleLabel?.font = UIFont.systemFont(ofSize: titleFont)}
        }
    }
    
    var subjectColor = UIColor.orange {
        didSet {
            _ = buttons.map({ (button) -> ZFSegmentBtn in
                button.setTitleColor(subjectColor, for: .selected)
                button.lineColor = subjectColor
                return button
            })
        }
    }
    var normalColor = UIColor.black {
        didSet {
            _ = buttons.map {$0.setTitleColor(normalColor, for: .normal)}
        }
    }
    var buttons: [ZFSegmentBtn] = []
    var delegate: ZFSegmentBarDelegate!
    
    var selectIndex = 0 {
        didSet {
            buttons[oldValue].isSelected = false
            buttons[selectIndex].isSelected = true
        }
    }
    init(frame: CGRect, titles: [String], delegate: ZFSegmentBarDelegate) {
        super.init(frame: frame)
        self.titles = titles
        self.delegate = delegate
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        let buttonW = frame.width / CGFloat(titles.count)
        for (i,title) in titles.enumerated() {
            let button = ZFSegmentBtn(frame: CGRect(x: buttonW * CGFloat(i), y: 0, width: buttonW, height: frame.height))
            button.tag = i
            button.setTitle(title, for: .normal)
            button.setTitleColor(normalColor, for: .normal)
            button.setTitleColor(subjectColor, for: .selected)
            button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
        }
        selectIndex = 0
//        buttons[selectIndex].isSelected = true
    }
    @objc fileprivate func buttonClick(_ button: ZFSegmentBtn) {
        let selIndex = button.tag
        self.selectIndex = selIndex
        self.delegate.segmentBar(self, index: selIndex)
    }

}
