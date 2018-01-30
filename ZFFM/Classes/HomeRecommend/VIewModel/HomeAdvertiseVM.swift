//
//  HomeAdveriseVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class HomeAdvertiseVM: NSObject {
    
     var advertises = [HomeAdvertiseModel]()
    
    /// 加载首页广告
    func loadAdversiseData(_ isSuccess: @escaping (_ success: Bool)->()) {
        let urlString = kBaseUrl + "mobile/discovery/v4/recommends"
        let parameters = ["channel": "ios-b1",
                          "device": "iPhone",
                          "includeActivity": "true",
                          "includeSpecial": "true",
                          "scale": "2",
                          "version": "5.4.21"]
        let resource = Resource(requestUrl: urlString, requestParam: parameters) { (rootDict) -> [HomeAdvertiseModel]? in
            guard let advertiseArr = rootDict["focusImages"]?["list"] as? [[String:Any]]else {return nil}
            guard let advertiseModelArr = HomeAdvertiseModel.mj_objectArray(withKeyValuesArray: advertiseArr) as? [HomeAdvertiseModel] else {return nil}
            return advertiseModelArr
        }
        resource.requestData { (advertiseModels) in
            self.advertises = advertiseModels!
            isSuccess(true)
        }
    }

}
