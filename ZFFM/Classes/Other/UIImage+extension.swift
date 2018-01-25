//
//  UIImage+extension.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/15.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    /// 重绘一张指定尺寸的图
    @objc func compressAlignedImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let frame = CGRect(origin: CGPoint(), size: size)
        draw(in: frame)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    // 重绘一张图,有助于减少内存
    @objc func compressImage() -> UIImage! {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint())
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage!
    }
    
    //切圆角
    @objc func circularImage(size: CGSize, backColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let rect = CGRect(origin: CGPoint(), size: size)
        //填充背景色
        backColor.setFill()
        UIRectFill(rect)
        //切圆角
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        draw(in: rect)
        //加圆框
//        path.lineWidth = 2
//        UIColor.lightGray.setStroke()
//        path.stroke()
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
}




