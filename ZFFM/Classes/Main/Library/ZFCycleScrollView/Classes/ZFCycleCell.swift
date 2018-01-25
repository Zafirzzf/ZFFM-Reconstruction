//
//  ZFCycleCell.swift
//  ZFCycleScrollView
//
//  Created by 周正飞 on 2017/6/29.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFCycleCell: UICollectionViewCell {
     let imageView = UIImageView()
     var placeHolderImage: UIImage?
     var picUrl: String? {
        didSet {
            downloadImage(urlStr: picUrl!)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.frame = bounds
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func downloadImage(urlStr: String) {
        let cacheImage = ZFCyclePersistency.getCacheImage(urlStr)
        if let cacheImage = cacheImage {
            imageView.image = cacheImage.compressImage(size: bounds.size)
        }else {
            imageView.image = placeHolderImage
            DispatchQueue.global().async {
                if let image = (URL(string: urlStr).flatMap{ try?Data(contentsOf: $0)}.flatMap{ UIImage(data: $0)}) {
                    DispatchQueue.main.async(execute: {
                        self.imageView.image = image.compressImage(size: self.bounds.size)
                        ZFCyclePersistency.saveImage(image, urlStr)
                    })
                }
            }
        }
     
    }
}
extension UIImage {
    @objc func compressImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let rect = CGRect(origin: CGPoint(), size: size)
        draw(in: rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}
