//
//  HomeAdveriseVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/3.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class HomeAdvertiseVM: NSObject {
    
    @objc var advertises = [HomeAdvertiseModel]()
    
    
     @objc func loadAdversiseData(_ isSuccess: @escaping (_ success: Bool)->()) {
        HomeRecommendRequest.loadAdvertiers { (rootDict, error) in
            guard let rootDict =  rootDict else { return }
            guard let advertiseArr = rootDict["focusImages"]?["list"] as? [[String:Any]]else {return}
             let advertiseModelArr = HomeAdvertiseModel.mj_objectArray(withKeyValuesArray: advertiseArr)
            
            self.advertises = advertiseModelArr as! [HomeAdvertiseModel]
            isSuccess(true)
        }
    }
}
