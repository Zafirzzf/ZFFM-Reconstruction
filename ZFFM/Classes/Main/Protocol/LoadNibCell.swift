//
//  LoadNibCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/7/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
protocol LoadNibCell {
    
}
// MARK: - 从nib中快速加载cell的方法
extension LoadNibCell where Self: UITableViewCell {
    static func cellWithTableView(_ tableView: UITableView) -> Self {
        let cellID = NSStringFromClass(self).components(separatedBy: ".").last!
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? Self
        if cell == nil {
            cell = (Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self)
    
        }
        return cell!
    }
    
}

