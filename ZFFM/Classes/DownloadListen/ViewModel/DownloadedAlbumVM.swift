//
//  DownloadedAlbumVM.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/20.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class DownloadedAlbumVM {
     class func setModelToCell(_ model : DownloadAlbumModel, _ cell: DownloadedAlbumCell) {
        cell.albumImageView.zf_setImage(with: model.coverSmall)
        cell.albumTitleLabel.text = model.albumTitle
        cell.albumPartsBtn.setTitle("1", for: .normal)
        cell.albumAnthorLabel.text = "by " + model.nickname
        cell.albumPartsSizeBtn.setTitle(model.fileFormatSize, for: .normal)
        
        cell.deleteClick = {
            DownloadDataTool.deleteDownloadedAlbum(model)
            
        }
    }
}
