//
//  AlbumRequest.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/8/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AlbumRequest: NetworkTool {

    /**
     *  订阅板块 - 网络请求API
     */
    class func getRecommondList(_ completion: @escaping NetworkCompletion) {
        let urlString = kBaseUrl + "feed/v2/feed/dynamic"
        let param = ["device" : "iPhone",
                     "sign" : "2",
                     "size" : "30",
                     "ts" : "1471074515.126522",
                     "tsuid" : "43342908"]
        let headers = ["User-Agent": "ting_v5.4.39_c5(CFNetwork, iPhone OS 10.0.1,iPhone8,1)",
                       "Cookie" : "domain=.ximalaya.com; path=/; channel=ios-b1; 1&_device=iPhone&5C60B916-A283-4DD3-98B1-8C42A8A889CF&5.4.39; impl=com.gemd.iting; NSUP=42E2BCFA%2C41B9139F%2C1477444624265; XUM=5C60B916-A283-4DD3-98B1-8C42A8A889CF; c-oper=%E6%9C%AA%E7%9F%A5; net-mode=WIFI; res=750%2C1334; idfa=5C60B916-A283-4DD3-98B1-8C42A8A889CF"]
        request(url: urlString, method: .GET, parameters: param, headers: headers, completion: completion)
    }
    /**
     *  专辑详情 - 节目
     */
    
    class func getAlbumMenu(_ albumId: String, _ completion: @escaping NetworkCompletion) {
        let urlString = kBaseUrl + "mobile/v1/album"
        let param = ["albumId" : albumId,
                     "device" : "iPhone",
                     "pageSize" : "20",
                     "source": "0",
                     "statEvent" : "pageview/Falbum/" + albumId,
                     "statModule": "推荐",
                     "statPage" : "tab/订阅听_推荐",
                     "statPosition": "1"]
        request(url: urlString, method: .GET, parameters: param, completion: completion)
    }
    
    /**
     *  专辑详情 - 详情
     */
    class func getAlbumDetail(_ albumId: String, _ completion: @escaping NetworkCompletion) {
        let urlString = kBaseUrl + "mobile/v1/album/detail"
        let param = ["albumId" : albumId,
                     "device" : "iPhone",
                     "pageSize" : "20",
                     "source": "0",
                     "statEvent" : "pageview/Falbum" + albumId,
                     "statModule": "推荐",
                     "statPage" : "tab/订阅听_推荐",
                     "statPosition": "1"]
        request(url: urlString, method: .GET, parameters: param, completion: completion)
    }
    
    class func getAlbumTrackList(_ albumId: String, _ completion: @escaping NetworkCompletion) {
        let urlString = kBaseUrl + "mobile/v1/album/track"
        let param = ["albumId" : albumId,
                     "isAsc" : "true",
                     "device" : "iPhone",
                     "pageSize" : "20",
                     "statEvent" : "pageview/Falbum/" + albumId,
                     "statModule": "小编推荐",
                     "statPage" : "albumlist/小编推荐",
                     "statPosition": "1"]
        request(url: urlString, method: .GET, parameters: param, completion: completion)
    }
    
    /**
     *  批量下载
     */
    class func getDownloadList(_ albumId: String, postion: Int, _ completion:@escaping NetworkCompletion) {
        let urlString = kBaseUrl + "mobile/api1/download/album/3404911/1/true"
        let parame = ["device" : "iPhone",
                      "statEvent" : "pageview/album" + albumId,
                      "statModule": "推荐",
                      "statPage" : "tab@订阅听_推荐",
                      "statPosition": "\(postion)"]
        request(url: urlString, method: .GET, parameters: parame, completion: completion)
    }
    
    
    
    
    
    
}







