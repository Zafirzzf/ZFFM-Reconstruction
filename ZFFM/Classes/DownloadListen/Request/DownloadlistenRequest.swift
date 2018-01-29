//
//  DownloadListenRequest.swift
//  ZFDownloaderDemo
//
//  Created by 周正飞 on 2017/9/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import MJExtension
import RealmSwift
class DownloadListenRequest: NetworkTool {
    
    
  
    
//     加载节目分类所有标题
    class func getTodayFireShareAndCategoryData(_ completion: @escaping (_ shareModel: ListenShareModel?, _ categorys: [ListenCategoryModel]) -> ()) {

        let url = kBaseUrl + "mobile/discovery/v2/rankingList/track"
        let param = ["device" : "iPhone",
                     "key" : "ranking:track:scoreByTime:1:0",
                     "pageId" : "1",
                     "pageSize" : "0"]
        request(url: url, method: .GET, parameters: param) { (resultDict, error) in

            guard let resultDict = resultDict else {return}
            let shareModel = ListenShareModel.mj_object(withKeyValues: resultDict["shareContent"])
            let categoryModel = ListenCategoryModel()
            categoryModel.key = "ranking:track:scoreByTime:1:0"
            categoryModel.name = "总榜"

            var categoryMs = ListenCategoryModel.mj_objectArray(withKeyValuesArray: resultDict["categories"]) as! [ListenCategoryModel]
            categoryMs.insert(categoryModel, at: 0)
            completion(shareModel, categoryMs)

        }
    }
    // 加载某一分类下的声音列表
    class func getVoiceMsWithKey(_ key: String, _ pageNum: Int, _ completion: @escaping NetworkCompletion) {
        
        let url = kBaseUrl + "mobile/discovery/v2/rankingList/track"
        let param = ["device" : "iPhone",
                     "key": key,
                     "pageId" : "1",
                     "pageSize": "30"]
        request(url: url, method: .GET, parameters: param, completion: completion)
    }
    
    // 获取某一条声音的下载信息
    class func setDownloadMessageToVoiceM(_ model: DownloadVoiceModel, _ complete: @escaping ()->()) {
        
        let url = "http://mobile.ximalaya.com/mobile/download/" + model.uid + "/track/" + model.trackId
        request(url: url, method: .POST, parameters: nil) { (resultDict, error) in

            model.mj_setKeyValues(resultDict)
            
            complete()
        }
    }
    
    
    
    
}




