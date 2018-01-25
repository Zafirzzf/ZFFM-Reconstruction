//
//  MineSettingCell.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class MineSettingCell: UITableViewCell {

    var rowItem: MineSettingRowItem? {
        didSet{
            setRowItem()
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @objc static func cellWith(_ tableView: UITableView, _ style: UITableViewCellStyle) -> MineSettingCell{
        let cellId = "MineSettingCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MineSettingCell
        if cell == nil {
            cell = MineSettingCell(style: style, reuseIdentifier: nil)
//            cell?.layer.cornerRadius = 10
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.selectionStyle = .none
        }
        return cell!
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - 赋值
extension MineSettingCell {
    fileprivate func setRowItem() {
        guard let item = rowItem else {return}
        imageView?.image = item.image
        textLabel?.text = item.title
        detailTextLabel?.text = item.detailTitle
        
        switch item.arrowType {
        case .defaultType:
            accessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 15),
                                        image: #imageLiteral(resourceName: "cell_arrow_all"))
        case .switchType:
            accessoryView = UISwitch()
        case .buttonType:
            accessoryView = MineSettingArrowBtn(title: item.arrowTitle)
        }
    }
    
    
}




