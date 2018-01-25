//
//  ZFCyclePersistency.swift
//  ZFCycleScrollView
//
//  Created by 周正飞 on 2017/6/29.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class ZFCyclePersistency {
    // 从缓存中取图片
   class func getCacheImage(_ fileName: String) -> UIImage? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/" + fileNameToCacheName(fileName)
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
    
    // 缓存图片
    class func saveImage(_ image: UIImage?, _ fileName: String) {
        guard let image = image else {return}
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/" + fileNameToCacheName(fileName)
        guard let imageData = UIImagePNGRepresentation(image) else {return}
        try?imageData.write(to: URL(fileURLWithPath: path), options: [.atomic])
        
    }
    class func fileNameToCacheName(_ fileName: String) -> String {
        return fileName.replacingOccurrences(of: "/", with: "")
    }
}
