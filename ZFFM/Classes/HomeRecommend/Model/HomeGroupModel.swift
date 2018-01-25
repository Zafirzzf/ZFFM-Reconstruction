//
//  HomeGroupModel.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/4.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import YYModel
enum HomeCellType: Int {
    case CellTypeList1 = 0
    case CellTypeList2 = 1
    case CellTypeList3 = 2
}

class HomeGroupModel: NSObject {
    
    @objc var title = ""
    @objc var hasMore = false
    @objc var list = [Any]()
    @objc var liveMs: [HomeLiveModel] = []
    @objc var spreadMs: [HomeSpreadModel] = []
    var cellType: HomeCellType = HomeCellType.CellTypeList1
    @objc var sortID = 0
    

    override var description: String {
        return yy_modelDescription()
    }
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["list" : HomeItemCellModel.self]
    }
  
}

