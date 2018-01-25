//
//  BaseSettingController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/12/6.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class BaseSettingController: BaseViewController {

    var groupArray = [MineSettingGroupItem]()
    
    override init(style: UITableViewStyle) {
        super.init(style: .grouped)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
extension BaseSettingController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray[section].itemArr.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MineSettingCell.cellWith(tableView, .default)
        cell.rowItem = groupArray[indexPath.section].itemArr[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = groupArray[indexPath.section].itemArr[indexPath.row]
        let vcClass: AnyClass? = NSClassFromString( item.className)
        guard let clsType = vcClass as? UIViewController.Type else {
            return
        }
        navigationController?.pushViewController(clsType.init(), animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if groupArray[section].headerTitle == nil {
            return nil
        }
        // 暂时没有
        return nil
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if groupArray[section].headerTitle == nil {
            return 0
        }
        return 0
    }
}








