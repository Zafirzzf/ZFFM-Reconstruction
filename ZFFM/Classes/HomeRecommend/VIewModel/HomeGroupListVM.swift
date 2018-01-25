//
//  HomeGroupListVM.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/4.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeGroupListVM: NSObject {

    @objc var groupModels: [HomeGroupModel] = [] {
        didSet {
            groupModels = groupModels.sorted(by: { (model1, model2) -> Bool in
                return model1.sortID < model2.sortID
            })
        }
    }
    
    // 小编推荐
    @objc func loadEditorRecommond(_ completion: @escaping ()->()) {
        HomeRecommendRequest.loadEdiotrRecommend { (groupModel) in
            groupModel.sortID = 1
            self.groupModels.append(groupModel)
            completion()
        }
    }
    // 现场直播
    @objc func loadLiveData(_ completion: @escaping ()->() ) {
        HomeRecommendRequest.loadLiveMs { (groupModel) in
            groupModel.sortID = 2
            self.groupModels.append(groupModel)
            completion()
        }
    }
    // 听广州
    @objc func loadCityAlbum(_ completion: @escaping ()->()) {
        HomeRecommendRequest.loadCityAlbums { (groupModel) in
            groupModel.sortID = 3
            self.groupModels.append(groupModel)
            completion()
        }
    }
    // 精品听单
    @objc func loadSpecialAlbum(_ completion:@escaping ()->()) {
        HomeRecommendRequest.loadSpecialAlbums { (groupModel) in
            groupModel.sortID = 4
            self.groupModels.append(groupModel)
            completion()
        }
    }
    // 推广
    @objc func loadSpreadData(_ completion:@escaping ()->()) {
        HomeRecommendRequest.loadSpreadAD { (groupModel) in
            guard let groupModel = groupModel else {completion() ; return }
            groupModel.sortID = 5
            self.groupModels.append(groupModel)
            completion()
        }
    }
    // 精品推荐
    @objc func loadHotRecommond(_ completion:@escaping ()->()) {
        HomeRecommendRequest.loadHotRecommondAlbums { (groupModels) in
            self.groupModels = self.groupModels + groupModels
            completion()
        }
    }
    
}
