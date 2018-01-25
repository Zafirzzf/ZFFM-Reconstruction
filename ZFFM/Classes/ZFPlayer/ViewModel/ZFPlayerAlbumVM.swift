//
//  ZFPlayerAlbumVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/11/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFPlayerAlbumVM {

    var coverSmall = ""
    var title = ""
    var intro = ""
    var shares = ""
    var tracks = ""
    var cellHeight: CGFloat = 100
    init(_ albumInfoM: AlbumInfoModel) {
        self.coverSmall = albumInfoM.coverSmall
        self.title = albumInfoM.title
        self.intro = albumInfoM.intro
        self.shares = String(format: "%.01f万", albumInfoM.shares)
        self.tracks = albumInfoM.tracks + "集"
        
        
        
    }
    
}
