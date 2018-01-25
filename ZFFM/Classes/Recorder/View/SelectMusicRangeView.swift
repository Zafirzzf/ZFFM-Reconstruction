//
//  SelectMusicRangeView.swift
//  ZFAudioRecoder
//
//  Created by 周正飞 on 2017/11/30.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class SelectMusicRangeView: UIView {

    fileprivate let leftBorderView = UIView()
    fileprivate let rightBorderView = UIView()
    fileprivate let leftTimeLabel = SelectMusicTimeLabel()
    fileprivate let rightTimeLabel = SelectMusicTimeLabel()
    fileprivate let msgLabel = UILabel()
    fileprivate let rangeContainerView = UIView()
    @objc lazy var indicateProgressView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: -5, width: 2, height: self.bounds.height + 10))
        view.backgroundColor = UIColor.white
        self.rangeContainerView.addSubview(view)
        return view
    }()
    /// 当前进度
    @objc var progress: CGFloat = 0 {
        didSet {
            indicateProgressView.frame.origin.x = rangeContainerView.bounds.width * progress
        }
    }
    /// 音频总时长
    @objc var totalTime: CGFloat = 0 {
        didSet {
            rightTimeLabel.timeSec = totalTime
        }
    }
    /// 左选择器的比率
    @objc var leftRangeRate: CGFloat {
        get {
            return leftBorderView.frame.origin.x / rangeContainerView.bounds.width
        }
    }
    @objc var rightRangeRate: CGFloat {
        get {
            return rightBorderView.frame.origin.x / rangeContainerView.bounds.width
        }
    }
    @objc var endMovedLeftRange: ((_ left: CGFloat) -> ())?
    @objc var endMovedRightRange: ((_ rightTime: CGFloat) -> ())?
    @objc var ensureSelRange: ((_ left: CGFloat, _ right: CGFloat) -> ())?
    fileprivate var leftBorderBeginX: CGFloat = 0
    fileprivate var rightBorderBeginX: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print(gestureRecognizer.self)
        return true
    }
    
}
// MARK: - 事件响应
extension SelectMusicRangeView {
    func reSelectMusic() {
        
    }
    
    @objc fileprivate func leftRangeMove(_ gesture: UIPanGestureRecognizer) {
        let movePoint = gesture.translation(in: self)
        switch gesture.state {
        case .began:
            leftBorderBeginX = leftBorderView.frame.origin.x
        case .changed:
            guard verifyRange() else {return}
            leftBorderView.frame.origin.x = leftBorderBeginX + movePoint.x
            leftTimeLabel.timeSec = totalTime * leftRangeRate
        case .ended:
            endMovedLeftRange?(leftRangeRate)
            break
        default :
            break;
        }
    }
    @objc fileprivate func rightRangeMove(_ gesture: UIPanGestureRecognizer) {
        let movePoint = gesture.translation(in: self)
        switch gesture.state {
        case .began:
            rightBorderBeginX = rightBorderView.frame.origin.x
        case .changed:
            guard verifyRange() else {return}
            rightBorderView.frame.origin.x = rightBorderBeginX + movePoint.x
            rightTimeLabel.timeSec = totalTime * rightRangeRate
        case .ended:
            if indicateProgressView.frame.maxX > rightBorderView.frame.maxX {
                indicateProgressView.frame.origin.x = rightBorderView.frame.origin.x
            }
            endMovedRightRange?(rightRangeRate)
            break
        default :
            break;
        }
    }
    fileprivate func verifyRange() -> Bool{
        return rightBorderView.frame.origin.x > leftBorderView.frame.origin.x
    }
    @objc fileprivate func ensureClick() {
        ensureSelRange?(leftRangeRate,rightRangeRate)
    }
}

// MARK: - 设置UI界面
extension SelectMusicRangeView {
    fileprivate func initialize() {
        backgroundColor = UIColor.lightGray
        setSelectRangeView()
    }
    fileprivate func setSelectRangeView() {
        // 选取范围Label
        msgLabel.frame = CGRect(x: 10, y: 0, width: 50, height: bounds.height)
        msgLabel.center.y = bounds.height * 0.5
        msgLabel.text = "选取范围"
        msgLabel.sizeToFit()
        msgLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(msgLabel)
        
        // 确认按钮
        let sureBtn = UIButton(frame: CGRect(x: frame.maxX - 50, y: 0, width:40 , height: bounds.height))
        sureBtn.titleLabel?.sizeToFit()
        sureBtn.setTitle("确认", for: .normal)
        sureBtn.setTitleColor(UIColor.black, for: .normal)
        sureBtn.addTarget(self, action: #selector(ensureClick), for: .touchUpInside)
        addSubview(sureBtn)
        
        // 播放范围容器view
        rangeContainerView.frame = CGRect(x: msgLabel.frame.maxX + 10, y: 0, width: bounds.width - msgLabel.bounds.width - sureBtn.bounds.width - 30 - 20, height: bounds.height)
        addSubview(rangeContainerView)
        
        // 左右边界选取
        leftBorderView.frame = CGRect(x: 0, y: 0, width: 15, height: frame.height)
        rightBorderView.frame = CGRect(x: rangeContainerView.bounds.width - 15, y: 0, width: 15, height: frame.height)
        leftBorderView.backgroundColor = UIColor.blue
        rightBorderView.backgroundColor = UIColor.blue
        leftBorderView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(leftRangeMove(_:))))
        rightBorderView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(rightRangeMove(_:))))
        
        // 左右时间提示label
        leftTimeLabel.frame = CGRect(x: 0, y: -20, width: 40, height: 20)
        rightTimeLabel.frame = CGRect(x: 0, y: -20, width: 40, height: 20)
        leftTimeLabel.timeSec = 0
        rightTimeLabel.timeSec = totalTime
        leftBorderView.addSubview(leftTimeLabel)
        rightBorderView.addSubview(rightTimeLabel)
        rangeContainerView.addSubview(leftBorderView)
        rangeContainerView.addSubview(rightBorderView)
        
    }
    
}










