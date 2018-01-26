//
//  HomeRequestTool.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/28.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import MJExtension
class HomeRecommendRequest: NetworkTool {
    
    /// 加载首页广告
   class func loadAdvertiers(_ completion:@escaping NetworkCompletion) {
    
        let urlString = kBaseUrl + "mobile/discovery/v4/recommends"
        let parameters = ["channel": "ios-b1",
                          "device": "iPhone",
                          "includeActivity": "true",
                          "includeSpecial": "true",
                          "scale": "2",
                          "version": "5.4.21"]
        request(url: urlString, method: .GET, parameters: parameters, completion: completion)
    }
    // 加载 "图文菜单"
    class func loadPicMenuList(_ result: @escaping NetworkCompletion) {
        
        let urlString = kBaseUrl + "mobile/discovery/v2/recommend/hotAndGuess"
        let parameters = ["device": "iPhone",
                          "version": "5.4.21"]
        request(url: urlString, method: .GET, parameters: parameters) { (rootDict, error) in
            guard error == nil else {
                result([:], error!)
                return
            }
            guard let rootDict = rootDict else{ return }
            result(rootDict, error)
//            let resultArr = rootDict["discoveryColumns"]?["list"] as! [Any]
        }
    }
    
    // 加载 "小编推荐"
    class func loadEdiotrRecommend(_ result: @escaping (_ resultModel: HomeGroupModel)->()) {
        
        let urlString = kBaseUrl + "mobile/discovery/v4/recommends"
        let parameters = ["channel": "ios-b1",
                          "device": "iPhone",
                          "includeActivity": "true",
                          "includeSpecial": "true",
                          "scale": "2",
                          "version": "5.4.21"]
        
        request(url: urlString, method: .GET, parameters: parameters) { (rootDict, error) in
            guard error == nil else { print(error as Any); return}
            guard let rootDict = rootDict else {return}
            let resultDict = rootDict["editorRecommendAlbums"] as! [String : Any]
            let groupModel = HomeGroupModel.mj_object(withKeyValues: resultDict)
            groupModel?.cellType = .CellTypeList3
            result(groupModel!)
        }
    }
    
    // 加载 "现场直播"
    class func loadLiveMs(_ result: @escaping (_ resultModel: HomeGroupModel)->()) {
        let urlString = kLiveUrl + "live-activity-web/v3/activity/recommend"
        request(url: urlString, method: .GET, parameters: nil) { (rootDict, error) in
            guard error == nil else {
                return
            }
            let liveModelArr = HomeLiveModel.mj_objectArray(withKeyValuesArray: rootDict?["data"]) as! [HomeLiveModel]
            let groupModel = HomeGroupModel()
            groupModel.liveMs = liveModelArr
            groupModel.cellType = .CellTypeList1
            groupModel.title = "现场直播"
            groupModel.hasMore = true
            result(groupModel)
        }
    }
    // 加载"听广州"
    class func loadCityAlbums(_ result: @escaping (_ resultModel: HomeGroupModel)->()) {
        
        let urlString = kBaseUrl + "mobile/discovery/v2/recommend/hotAndGuess"
        let parameters = ["code": "43_440000_4401",
                          "device": "iPhone",
                          "version": "5.4.21"]
        request(url: urlString, method: .GET, parameters: parameters) { (rootDict, error) in
            guard error == nil else { print(error as Any); return}
            guard let rootDict = rootDict else {return}
            let resultDict = rootDict["cityColumn"] as! [String : Any]
            let groupModel = HomeGroupModel.mj_object(withKeyValues: resultDict)
            groupModel?.cellType = .CellTypeList3
            result(groupModel!)
        }
    }
    // 加载"精品听单"
    class func loadSpecialAlbums(_ result:@escaping(_ resultModel: HomeGroupModel)->()) {
        
        let urlString = kBaseUrl + "mobile/discovery/v4/recommends"
        let parameters = ["channel": "ios-b1",
                          "device": "iPhone",
                          "includeActivity": "true",
                          "includeSpecial": "true",
                          "scale": "2",
                          "version": "5.4.21"]
        request(url: urlString, method: .GET, parameters: parameters) { (rootDict, error) in
            guard error == nil else { print(error as Any); return}
            guard let rootDict = rootDict else {return}
            let resultDict = rootDict["specialColumn"] as! [String : Any]
          
            let groupModel = HomeGroupModel.mj_object(withKeyValues: resultDict)
            groupModel?.cellType = .CellTypeList2
            result(groupModel!)
        }
    }
    // 加载 "推广"
    class func loadSpreadAD(_ result:@escaping (_ resultModel: HomeGroupModel?)->()) {
        
        let urlString = kAdUrl + "/ting/feed"
        let param = ["appid": "0",
                     "device": "iPhone",
                     "name": "find_native",
                     "network": "WIFI",
                     "operator": "3",
                     "scale": "2",
                     "version": "5.4.21"]
        request(url: urlString, method: .GET, parameters: param) { (rootDict, error) in
            guard let rootDict = rootDict else {return}
            let spreadMs = HomeSpreadModel.mj_objectArray(withKeyValuesArray: rootDict["data"]) as! [HomeSpreadModel]
            if spreadMs.count == 0 { result(nil) ;return}
            let groupModel = HomeGroupModel()
            groupModel.spreadMs = spreadMs
            groupModel.title = "推广"
            groupModel.cellType = .CellTypeList1
            groupModel.hasMore = true
            result(groupModel)
        }
    }
    // 加载 "热门推荐"
    class func loadHotRecommondAlbums(_ result:@escaping (_ groupModels:[HomeGroupModel])->()) {
        
        let urlString = kBaseUrl + "mobile/discovery/v2/recommend/hotAndGuess"
        let param = ["code": "43_440000_4401",
                     "device": "iPhone",
                     "version": "5.4.21"]
        request(url: urlString, method: .GET, parameters: param) { (rootDict, error) in
            guard let rootDict = rootDict else {return}
            let groupMs = HomeGroupModel.mj_objectArray(withKeyValuesArray: rootDict["hotRecommends"]?["list"] as Any) as! [HomeGroupModel]
            for (i,groupModel) in groupMs.enumerated() {
                groupModel.sortID = 10 + i
                groupModel.cellType = .CellTypeList3
            }
            result(groupMs)
        }
    }
}













