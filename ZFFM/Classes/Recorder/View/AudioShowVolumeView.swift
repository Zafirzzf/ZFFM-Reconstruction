//
//  AudioShowVolumeView.swift
//  ZFAudioRecoder
//
//  Created by 周正飞 on 2017/12/7.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
private let KTotalVolume: CGFloat = 150
class AudioShowVolumeView: UIView {

    fileprivate var volumeImageVArr = [UIImageView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()

    }
    @objc var currentVolume: CGFloat = 0 {
        didSet {
            setVolume()
        }
    }
    
 

}


// MARK: - 对外提供方法
extension AudioShowVolumeView {

}

// MARK: - 设置UI
extension AudioShowVolumeView {
    fileprivate func setupUI() {
        /// 麦克风图标
        let recorderImageV = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 30))
        recorderImageV.image = #imageLiteral(resourceName: "recorder")
        addSubview(recorderImageV)
        recorderImageV.center.y = frame.height * 0.5
        
        /// 音量图标
        for index in 0 ... 14 {
           let imageView = UIImageView(image: #imageLiteral(resourceName: "volumeUnlight"))
            imageView.frame = CGRect(x: recorderImageV.frame.maxX + 10 + CGFloat(index * 18), y: 0, width: 15, height: 30)
            imageView.center.y = frame.height * 0.5
            imageView.highlightedImage = #imageLiteral(resourceName: "volumeLight")
            addSubview(imageView)
            volumeImageVArr.append(imageView)
        }
    }

}

// MARK: - 方法抽取
fileprivate let KAnimateTime: Double = 0.03
extension AudioShowVolumeView {
    fileprivate func setVolume() {
       let volImageNum = volumeImageVArr.count
        let volumeLev = Int( currentVolume / (150.0 / CGFloat(volImageNum)))
        if volumeLev == 0 {
            for (i,imageV) in volumeImageVArr[volumeLev...volImageNum-1].enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(11-i) * KAnimateTime, execute: {
                    imageV.isHighlighted = false
                })
            }
            return
        }
        if volumeLev == volImageNum {
            _ = volumeImageVArr.map {$0.isHighlighted = true}
            return
        }
        for (i,imageV) in volumeImageVArr[volumeLev...volImageNum-1].enumerated(){
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(11-i) * KAnimateTime, execute: {
                imageV.isHighlighted = false
            })
        }
        guard volumeLev > 0 else {return}
        for (i,imageV) in volumeImageVArr[0...volumeLev].enumerated() {
          
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * KAnimateTime, execute: {
                imageV.isHighlighted = true
            })
        }
        
    }
}

