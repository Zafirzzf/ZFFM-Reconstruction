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
    
    // 加载 "图文菜单"
    class func loadPicMenuList(_ result: @escaping ([HomeMenuModel]?) -> ()) {
        let urlString = kBaseUrl + "mobile/discovery/v2/recommend/hotAndGuess"
        let parameters = ["device": "iPhone",
                          "version": "5.4.21"]
        let resource = Resource(requestUrl: urlString, requestParam: parameters) { (rootDict) -> [HomeMenuModel]? in
            let resultArr = rootDict["discoveryColumns"]?["list"] as! [Any]
            return HomeMenuModel.mj_objectArray(withKeyValuesArray: resultArr) as? [HomeMenuModel]
        }
        resource.requestData(result)
        
    }
 
    // 加载 "小编推荐"
    class func loadEdiotrRecommend(_ result: @escaping (_ resultModel: HomeGroupModel?)->()) {
        let urlString = kBaseUrl + "mobile/discovery/v4/recommends"
        let parameters = ["channel": "ios-b1",
                         "device": "iPhone",
                         "includeActivity": "true",
                         "includeSpecial": "true",
                         "scale": "2",
                         "version": "5.4.21"]
       let groupResource = Resource(requestUrl: urlString, requestParam: parameters) { (rootDict) -> HomeGroupModel? in
            let rootDict = rootDict["editorRecommendAlbums"] as? [String : Any]
            let groupmodel =  HomeGroupModel.mj_object(withKeyValues: rootDict)
            groupmodel?.cellType = .CellTypeList3
            return groupmodel
        }
        groupResource.requestData(result)
    }

    // 加载"听广州"
    class func loadCityAlbums(_ result: @escaping (_ resultModel: HomeGroupModel?)->()) {
        
        let urlString = kBaseUrl + "mobile/discovery/v2/recommend/hotAndGuess"
        let parameters = ["code": "43_440000_4401",
                          "device": "iPhone",
                          "version": "5.4.21"]
        let resource = Resource(requestUrl: urlString, requestParam: parameters) { (rootDict) -> HomeGroupModel? in
            guard let resultDict = rootDict["cityColumn"] as? [String : Any] else {return nil}
            let groupModel = HomeGroupModel.mj_object(withKeyValues: resultDict)
            groupModel?.cellType = .CellTypeList3
            return groupModel
            
        }
        resource.requestData(result)
    }
    // 加载"精品听单"
    class func loadSpecialAlbums(_ result:@escaping(_ resultModel: HomeGroupModel?)->()) {
        let urlString = kBaseUrl + "mobile/discovery/v4/recommends"
        let parameters = ["channel": "ios-b1",
                          "device": "iPhone",
                          "includeActivity": "true",
                          "includeSpecial": "true",
                          "scale": "2",
                          "version": "5.4.21"]
        let resource = Resource(requestUrl: urlString, requestParam: parameters) { (rootDict) -> HomeGroupModel? in
            guard let resultDict = rootDict["specialColumn"] as? [String : Any] else {return nil}
            let model = HomeGroupModel.mj_object(withKeyValues: resultDict)
            model?.cellType = .CellTypeList2
            return model
        }
        resource.requestData(result)
        
    }
    
    // 加载 "热门推荐"
    class func loadHotRecommondAlbums(_ result:@escaping (_ groupModels:[HomeGroupModel]?)->()) {
        let urlString = kBaseUrl + "mobile/discovery/v2/recommend/hotAndGuess"
        let param = ["code": "43_440000_4401",
                     "device": "iPhone",
                     "version": "5.4.21"]
        let resource = Resource(requestUrl: urlString, requestParam: param) { (rootDict) -> [HomeGroupModel]? in
            
            guard let groupMs = HomeGroupModel.mj_objectArray(withKeyValuesArray: (rootDict["hotRecommends"] as?[String: AnyObject])?["list"]) as? [HomeGroupModel] else { return nil }
            for (i,groupModel) in groupMs.enumerated() {
                groupModel.sortID = 10 + i
                groupModel.cellType = .CellTypeList3
            }
            return groupMs
        }
        resource.requestData(result)
        
    }
  
    // 加载 "现场直播"
    class func loadLiveMs(_ result: @escaping (_ resultModel: HomeGroupModel?)->()) {
        
        let urlString = kLiveUrl + "live-activity-web/v3/activity/recommend"
        let resource = Resource(requestUrl: urlString, requestParam: [:]) { (rootDict) -> HomeGroupModel? in
            
            guard let liveModelArr = HomeLiveModel.mj_objectArray(withKeyValuesArray: rootDict["data"]) as? [HomeLiveModel] else {return nil}
            let model = HomeGroupModel("现场直播", cellType: .CellTypeList1, Models: liveModelArr, hasMore: true)
            return model
        }
        resource.requestData(result)
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
        let resource = Resource(requestUrl: urlString, requestParam: param) { (rootDict) -> HomeGroupModel? in
            guard let spreadMs = HomeSpreadModel.mj_objectArray(withKeyValuesArray: rootDict["data"]) as? [HomeSpreadModel]  else {return nil}
            guard spreadMs.count > 0 else {return nil}
            let model = HomeGroupModel("推广", cellType: .CellTypeList1, Models: spreadMs, hasMore: true)
            return model
        }
        resource.requestData(result)
    }
  
   
}













