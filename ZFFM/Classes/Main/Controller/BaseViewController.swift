//
//  BaseViewController.swift
//  ZFFM
//
//  Created by 周正飞 on 2017/6/29.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        tableView.backgroundColor = UIColor(hex: "#e1e1e1")
        tableView.separatorStyle = .none
        
    }
}
