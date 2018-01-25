//
//  KingfreshExtension.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/24.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import Kingfisher


extension UIImageView {
    
    @objc func zf_setImage(with urlString: String?, _ placeHolderName: String? = nil) {
        guard let urlString = urlString else { return }
        guard let imageUrl = URL(string: urlString) else { return }
        if let placeHolderName = placeHolderName {
            kf.setImage(with: imageUrl, placeholder : UIImage(named: placeHolderName), options: [.transition(ImageTransition.fade(0.15))])
        }else {
            kf.setImage(with: imageUrl)
        }
      
        
  //      kf.setImage(with: <#T##Resource?#>, placeholder: <#T##Image?#>, options: <#T##KingfisherOptionsInfo?#>, progressBlock: <#T##DownloadProgressBlock?##DownloadProgressBlock?##(Int64, Int64) -> ()#>, completionHandler: <#T##CompletionHandler?##CompletionHandler?##(Image?, NSError?, CacheType, URL?) -> ()#>)
    }
    @objc func zf_setCircularImage(_ urlString: String?,_ placeHolder: Image? = nil, backColor: UIColor = UIColor.white) {
        guard let urlString = urlString else { return }
        guard let imageUrl = URL(string: urlString) else {
            self.image = placeHolder
            return
        }

        kf.setImage(with: imageUrl, placeholder: placeHolder, options: [.transition(ImageTransition.fade(0.15))], progressBlock: nil) { (resultImage, error, type, url) in
            guard let image = resultImage else {return}
            self.image = image.circularImage(size: self.bounds.size, backColor: backColor)
        }
        
    }

    
}
