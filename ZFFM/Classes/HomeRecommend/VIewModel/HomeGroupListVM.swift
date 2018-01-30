//
//  HomeGroupListVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/4.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeGroupListVM: NSObject {

     var groupModels: [HomeGroupModel] = [] {
        didSet {
            groupModels = groupModels.sorted(by: { (model1, model2) -> Bool in
                return model1.sortID < model2.sortID
            })
        }
    }
    
    // 小编推荐
     func loadEditorRecommond(_ completion: @escaping ()->()) {
        HomeRecommendRequest.loadEdiotrRecommend { (groupModel) in
            guard let model = groupModel else {return}
            model.sortID = 1
            self.groupModels.append(model)
            completion()
        }
    }
    // 现场直播
     func loadLiveData(_ completion: @escaping ()->() ) {
        HomeRecommendRequest.loadLiveMs { (groupModel) in
            guard let model = groupModel else {return}
            model.sortID = 2
            self.groupModels.append(model)
            completion()
        }
    }
    // 听广州
     func loadCityAlbum(_ completion: @escaping ()->()) {
        HomeRecommendRequest.loadCityAlbums { (groupModel) in
            guard let model = groupModel else {return}
            model.sortID = 3
            self.groupModels.append(model)
            completion()
        }
    }
    // 精品听单
     func loadSpecialAlbum(_ completion:@escaping ()->()) {
        HomeRecommendRequest.loadSpecialAlbums { (groupModel) in
            guard let model = groupModel else {return}
            model.sortID = 4
            self.groupModels.append(model)
            completion()
        }
    }
    // 推广
     func loadSpreadData(_ completion:@escaping ()->()) {
        HomeRecommendRequest.loadSpreadAD { (groupModel) in
            guard let groupModel = groupModel else {completion() ; return }
            groupModel.sortID = 5
            self.groupModels.append(groupModel)
            completion()
        }
    }
    // 精品推荐
     func loadHotRecommond(_ completion:@escaping ()->()) {
        HomeRecommendRequest.loadHotRecommondAlbums { (groupModels) in
            guard let model = groupModels else {return}
            self.groupModels = self.groupModels + model
            completion()
        }
    }
    
}
