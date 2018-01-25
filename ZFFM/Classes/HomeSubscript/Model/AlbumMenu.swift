
//
//  AlbumMenu.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumMenu: NSObject {
    @objc var album: Album = Album()
    @objc var tracks = Tracks()
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["album" : Album.self,
                "tracks": Tracks.self]
    }
    override var description: String {
        return yy_modelDescription()
    }
}
